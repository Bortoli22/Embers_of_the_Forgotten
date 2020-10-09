extends KinematicBody2D


# Member variables here
export var playerGravity = 9.81
export var playerSpeed = 400
export var terminalVelocity = 1500
export var floatDenominator = 1.3
export var playerHealthMax = 1000

var playerVelocity = Vector2()
var playerHealth
var invulnTimer
var currency
var fsm #finite state machine
var xPositivity = true
var crouched = false


# Called when the node enters the scene tree for the first time.
func _ready():
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
	print(playerVelocity.y)
	
	#obtain new x velocity
	_inputSequence()
	
	# distance = velocity * time (right?)
	# playerDistance = playerVelocity * delta
	move_and_slide(playerVelocity, Vector2(0,-1))

# Get x velocity from LR inputs
func _inputSequence():
	
	if Input.is_action_pressed("ui_right") && !Input.is_action_pressed("ui_left"):
		fsm.travel("Run_Right")
		xPositivity = true
		if playerVelocity.x < playerSpeed:
			playerVelocity.x += (playerSpeed / 10)
		else:
			playerVelocity.x = playerSpeed
	elif Input.is_action_pressed("ui_left") && !Input.is_action_pressed("ui_right"):
		fsm.travel("Run_Left")
		xPositivity = false
		if playerVelocity.x > -playerSpeed:
			playerVelocity.x -= (playerSpeed / 10)
		else:
			playerVelocity.x = -playerSpeed
	else:
		if !crouched:
			if xPositivity:
				fsm.travel("Idle_Right")
			else:
				fsm.travel("Idle_Left")
		if playerVelocity.x > 1 || playerVelocity.x < -1:
			playerVelocity.x = playerVelocity.x / floatDenominator
		else:
			playerVelocity.x = 0

func damageHandler(dmgamount, kbdirection):
	if invulnTimer <= 0:
		invulnTimer = 2 #implement countdown in another delta function
		knockback(kbdirection)
		healthChange(dmgamount)

func knockback(kbdirection):
	#calculate knockback
	pass


func healthChange(amount):
	playerHealth += amount
	get_parent().get_node("HUD").change_health(playerHealth, float(playerHealth)/float(playerHealthMax))
