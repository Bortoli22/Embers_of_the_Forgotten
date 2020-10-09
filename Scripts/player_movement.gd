extends KinematicBody2D


# Member variables here
export var playerGravity = 9.81
export var playerSpeed = 400
export var terminalVelocity = 1500
export var sprintVelocity = 2500
export var floatDenominator = 1.3

var playerVelocity = Vector2()
var playerDistance
var currency = 0
var jump_power = 500
var jump_count = 0
const max_JC = 2
var fsm #finite state machine
var xPositivity = true
var crouched = false
var lastShot = OS.get_ticks_msec()

var sprinting = false
var wallgrabbing = false
#healthbar 
export var playerHealthMax = 1000
export var playerOnHitInvuln = 2
var playerHealth
var invulnTimer
var main
#placeholder for ability list
var abilities = ["wall_grab", "wall_jump"]



# Called when the node enters the scene tree for the first time.
func _ready():
	main = get_tree().get_root().get_node("Main")
	playerVelocity.y = playerGravity
	invulnTimer = 0
	initDefault() #TEMP
	fsm = $AnimationStateMachine.get("parameters/playback")

func initDefault():
	currency = 0
	playerHealth = playerHealthMax
	
func initLoad(stcurrency, stHealth):
	currency = stcurrency
	playerHealth = stHealth

# Called every phys frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
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
	#print(playerVelocity.y)
	
	#obtain new x velocity
	_inputSequence()
	# distance = velocity * time (right?)
	# playerDistance = playerVelocity * delta
	move_and_slide(playerVelocity, Vector2(0,-1))

# Get x velocity from LR inputs
func _inputSequence():
	lr_check()	
	wall_grab_check()
	jump_check()
	shoot_check()
	dodge_check()
		
func shoot_check():
	if Input.is_mouse_button_pressed(BUTTON_LEFT):
		shoot()
		
func lr_check():
	if Input.is_action_pressed("ui_right") && !Input.is_action_pressed("ui_left"):
		if wallgrabbing:
				playerVelocity.y = 0
		else: 
			fsm.travel("Run_Right")
			xPositivity = true
		#check if sprint key hit inside here
		if Input.is_action_pressed("ui_shift"):
			printerr("hit shift 1!")
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
			printerr("hit shift 2!")
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
		#invulnTimer = playerOnHitInvuln #implement countdown in another delta function
		knockback(direction, force)
		healthChange(dmgamount)
		if playerHealth == 0:
			#die i guess
			pass

func knockback(direction, force):
	playerVelocity.x += direction*force.x
	playerVelocity.y += force.y
	pass


func healthChange(amount):
	playerHealth -= amount
	if playerHealth < 0:
		playerHealth = 0
	main.get_node("CanvasLayer").get_node("HUD").change_health(playerHealth, float(playerHealth)/float(playerHealthMax))
	
func jump_check():
	if Input.is_action_pressed("ui_up"):
		if jump_count < max_JC: 
			playerVelocity.y = -jump_power
			jump_count += 1
			print(jump_count)
			#controls speed of descent after jump 
			playerVelocity.y += 200
			if xPositivity:
				fsm.travel("Jump_L")
			else:
				fsm.travel("Jump_R")
		else:
			if abilities.find("wall_jump") >= 0:
				if next_to_left_wall():
					playerVelocity.y = -jump_power
					playerVelocity.x += jump_power
					wallgrabbing = false
				if next_to_right_wall():
					playerVelocity.y = -jump_power
					playerVelocity.x -= jump_power
					wallgrabbing = false
	if is_on_floor():
		jump_count = 0
				
func wall_grab_check():
	
	if Input.is_action_pressed("wall_grab") && is_on_wall():
		if abilities.find("wall_grab") >= 0:
			wallgrabbing = true
			playerVelocity.y = 0
			jump_count = 0
	if Input.is_action_just_released("wall_grab"):
		wallgrabbing = false
			
func dodge_check():
	if Input.is_action_just_pressed("dodge"):
		playerVelocity.x = playerVelocity.x * 10
		
func next_to_left_wall():
	return $WallRaycasts/LeftRaycasts/LeftRay1.is_colliding() || $WallRaycasts/LeftRaycasts/LeftRay2.is_colliding()

func next_to_right_wall():
	return $WallRaycasts/RightRaycasts/RightRay1.is_colliding() || $WallRaycasts/RightRaycasts/RightRay2.is_colliding()
		
func shoot():
	if (OS.get_ticks_msec() - lastShot) > 500:
		var projectile = load("res://Scenes/projectile.tscn")
		var p = projectile.instance() #The actual projectile object in the scene.
		add_child_below_node(get_tree().get_current_scene(), p)
		lastShot = OS.get_ticks_msec()
