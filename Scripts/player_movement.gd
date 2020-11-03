extends KinematicBody2D


# Member variables here
export var playerGravity = 9.81
export var playerSpeed = 400
export var terminalVelocity = 1500
export var sprintVelocity = 2500
export var floatDenominator = 1.3

var playerVelocity = Vector2()
var playerDistance
var jump_power = 500
var jump_count = 0
const max_JC = 2
var fsm #finite state machine
var xPositivity = true
var crouched = false
var currentUse
var jumping
var holding

var sprinting = false
var wallgrabbing = false

#healthbar 
export var playerOnHitInvuln = 2
var invulnTimer
var main

var respawn_menu = preload("res://Scenes/RespawnMenu.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	PlayerData.playerNode = self
	main = self.get_parent()
	playerVelocity.y = playerGravity
	invulnTimer = 0
	holding = false
	initDefault() #TEMP
	fsm = $AnimationStateMachine.get("parameters/playback")

func initDefault():
	PlayerData.playerHealth = PlayerData.playerHealthMax
	PlayerData.wpnslot1 = $PlayerCenter/Sword # TEMP UNTIL PROPER EQUIPPING
	PlayerData.wpnslot2 = $PlayerCenter/Pistol # TEMP UNTIL PROPER EQUIPPING
	
func initLoad(stcurrency, stHealth):
	PlayerData.playerHealth = stHealth
	PlayerData.currency = stcurrency

# Called every phys frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	#disable actions if game is paused
	if GameData.paused || GameData.player_dead:
		return
	
	if PlayerData.playerHealth == 0: 
		GameData.player_dead = true
		respawn()
		GameData.player_dead = false
		return
	
	# obtain new y velocity and check crouch
	if is_on_floor():
		playerVelocity.y = playerGravity
		if Input.is_action_pressed("ui_down"):
			fsm.travel("Crouch_L")
			crouched = true
		else:
			crouched = false
	else:
		if playerVelocity.y < terminalVelocity:
			playerVelocity.y += delta * playerGravity 
			if Input.is_action_pressed("ui_down") && playerVelocity.y < terminalVelocity:
				playerVelocity.y += 50
		else: 
			playerVelocity.y = terminalVelocity
	
	
	#obtain new x velocity
	_inputSequence()
	# distance = velocity * time (right?)
	# playerDistance = playerVelocity * delta
	move_and_slide(playerVelocity, Vector2(0,-1))

# Get x velocity from LR inputs
func _inputSequence():
	pause_check()
	attack_check()
	lr_check()
	wall_grab_check()
	jump_check()
	dodge_check()
	use_check()
	
	if Input.is_action_just_pressed("kill_self"):
		healthChange(-PlayerData.playerHealthMax)
		
func pause_check():
	if Input.is_action_pressed("pause"):
		
		GameData.paused = true
		var pause_menu = load("res://Scenes/PauseMenu.tscn")
		self.add_child(pause_menu.instance())
	return
	
func attack_check():
	if (PlayerData.wpnactionable && !holding):
		if Input.is_action_just_pressed("pr_fire"):
			PlayerData.wpnactionable = false
			holding = true
			wslot1()
		elif Input.is_action_just_pressed("alt_fire"):
			PlayerData.wpnactionable = false
			holding = true
			wslot2()
	elif (Input.is_action_just_released("alt_fire") && holding):
		holding = false
	elif (Input.is_action_just_released("pr_fire") && holding):
		holding = false
func lr_check():
	if Input.is_action_pressed("ui_right") && !Input.is_action_pressed("ui_left"):
		if wallgrabbing:
				playerVelocity.y = 0
		else: 
			fsm.travel("Run_Right")
			xPositivity = true
		#check if sprint key hit inside here
		if Input.is_action_pressed("ui_shift"):
			sprinting = true
		else:
			sprinting = false
		#change the rate at which the player moves horizontally 
		fsm.travel("Run_Right")
		xPositivity = true
		if sprinting && is_on_floor():
			#increase player speed to 1.5x normal when sprinting
			#change this value in both if statements to make sprinting >1.5x
			playerSpeed = 600
			if playerVelocity.x < playerSpeed:
				playerVelocity.x += (playerSpeed)
			else:
				playerVelocity.x = playerSpeed
		else:			
			if wallgrabbing:
				playerVelocity.y = 0
			else: 
				fsm.travel("Run_Right")
				xPositivity = true
			if playerVelocity.x < playerSpeed:
				playerVelocity.x += (playerSpeed / 10)
			else:
				playerVelocity.x = playerSpeed
	elif Input.is_action_pressed("ui_left") && !Input.is_action_pressed("ui_right"):
		if wallgrabbing:
			  playerVelocity.y = 0
		else:
			fsm.travel("Run_Left")
			xPositivity = false
		#check if sprint key hit inside here
		if Input.is_action_pressed("ui_shift"):
			sprinting = true
		#change the rate at which the player moves horizontally 
		fsm.travel("Run_Left")
		xPositivity = false
		if sprinting && is_on_floor():
			playerSpeed = 600
			if playerVelocity.x > -playerSpeed:
				playerVelocity.x -= (playerSpeed)
			else:
				playerVelocity.x = -playerSpeed
		else:
			if wallgrabbing:
				playerVelocity.y = 0
			else:
				fsm.travel("Run_Left")
				xPositivity = false
			if playerVelocity.x > -playerSpeed:
				playerVelocity.x -= (playerSpeed / 10)
			else:
				playerVelocity.x = -playerSpeed	
	else:
		if !crouched && is_on_floor():
			if xPositivity:
				fsm.travel("Idle_Right")
			else:
				fsm.travel("Idle_Left")
		if playerVelocity.x > 1 || playerVelocity.x < -1:
			playerVelocity.x = playerVelocity.x / floatDenominator
		else:
			playerVelocity.x = 0

#Use this function for all non-DoT damage sources
func damageHandler(dmgamount, direction, force):
	if invulnTimer <= 0:
		invulnTimer = playerOnHitInvuln #implement countdown in another delta function
		knockback(direction, force)
		healthChange(-1*dmgamount)
		if PlayerData.playerHealth == 0:
			pass
		yield(get_tree().create_timer(playerOnHitInvuln), "timeout")
		invulnTimer = 0

func knockback(direction, force):
	playerVelocity.x += direction*force.x
	playerVelocity.y += force.y
	pass

func heal(value):
	if (PlayerData.playerHealth == PlayerData.playerHealthMax):
		return false
	elif (value + PlayerData.playerHealth > PlayerData.playerHealthMax):
		healthChange(PlayerData.playerHealthMax - PlayerData.playerHealth)
		return true
	else:
		healthChange(value)
		return true
	

func healthChange(amount):
	PlayerData.playerHealth += amount
	if PlayerData.playerHealth < 0:
		PlayerData.playerHealth = 0
	main.get_node("CanvasLayer").get_node("HUD").change_health(PlayerData.playerHealth, float(PlayerData.playerHealth)/float(PlayerData.playerHealthMax))
	
func jump_check():
	if Input.is_action_pressed("ui_up") && jumping != true:
		if jump_count < max_JC: 
			if playerSpeed != 600: capSpeed(600)
			jumping = true
			playerVelocity.y = -jump_power
			#controls speed of descent after jump 
			playerVelocity.y += 200
			if xPositivity:
				fsm.travel("Jump_L")
			else:
				fsm.travel("Jump_R")
		else:
			if PlayerData.check_abilities("walljump"):
				if next_to_left_wall():
					playerVelocity.y = -jump_power
					playerVelocity.y += 250
					#playerVelocity.x += jump_power
					playerVelocity.x = 100
					wallgrabbing = false
				if next_to_right_wall():
					playerVelocity.y = -jump_power
					playerVelocity.y += 250
					#playerVelocity.x -= jump_power
					playerVelocity.x = -100
					wallgrabbing = false
	elif Input.is_action_just_released("ui_up"):
		jump_count += 1
		jumping = false
	if is_on_floor():
		jump_count = 0
		jumping = false
				
func wall_grab_check():
	
	if Input.is_action_pressed("wall_grab") && is_on_wall():
		if PlayerData.check_abilities("wallgrab"):
			wallgrabbing = true
			playerVelocity.y = 0
			jump_count = 0
	if Input.is_action_just_released("wall_grab"):
		wallgrabbing = false
			
func dodge_check():
	if Input.is_action_just_pressed("dodge"):
		playerVelocity.x = playerVelocity.x * 10

func use_check():
	if Input.is_action_just_pressed("use") && currentUse != null:
		use(currentUse)
		

func next_to_left_wall():
	return $WallRaycasts/LeftRaycasts/LeftRay1.is_colliding() || $WallRaycasts/LeftRaycasts/LeftRay2.is_colliding()

func next_to_right_wall():
	return $WallRaycasts/RightRaycasts/RightRay1.is_colliding() || $WallRaycasts/RightRaycasts/RightRay2.is_colliding()
		
func wslot1():
	print(xPositivity)
	if (PlayerData.wpnslot1 != null && !PlayerData.wpnactionable):
		PlayerData.wpnslot1.attack(xPositivity)

func wslot2():
	if (PlayerData.wpnslot2 != null && !PlayerData.wpnactionable):
		PlayerData.wpnslot2.attack(xPositivity)



func use(object):
	
	if (object.type == "switch"):
		pass
	elif (object.type == "door"):
		pass
	elif (object.type == "health"):
		if (heal(object.value)):
			object.use()
		else:
			#flash_notice(1)
			pass
	elif (object.type == "money"):
		pass
	elif (object.type == "equippable"):
		pass
		
func clearUse():
	get_node("UsePrompt/Prompt").visible = false
	currentUse = null

func capSpeed(speed):
	playerSpeed = speed
	if (abs(playerVelocity.x) > playerSpeed && playerVelocity.x != 0):
		playerVelocity.x /= (abs(playerVelocity.x)/playerSpeed)

func _on_UsePrompt_body_entered(body):
	currentUse = body
	get_node("UsePrompt/Prompt").visible = true

func _on_UsePrompt_body_exited(body):
	clearUse()

func respawn():
	var tree = get_tree()
	var root = tree.get_root()
	self.add_child(respawn_menu.instance())
