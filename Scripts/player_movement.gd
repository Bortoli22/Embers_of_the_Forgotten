extends KinematicBody2D


# Member variables here
export var playerGravity = 9.81
export var playerSpeed = 400
export var terminalVelocity = 1500
export var floatDenominator = 1.3
var playerVelocity = Vector2()
var playerDistance
var currency = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	playerVelocity.y = playerGravity


# Called every phys frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	# obtain new y velocity and check crouch
	if is_on_floor():
		playerVelocity.y = playerGravity
		if Input.is_action_pressed("ui_down"):
			print("is crouched")
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
		if playerVelocity.x < playerSpeed:
			playerVelocity.x += (playerSpeed / 10)
		else:
			playerVelocity.x = playerSpeed
	elif Input.is_action_pressed("ui_left") && !Input.is_action_pressed("ui_right"):
		if playerVelocity.x > -playerSpeed:
			playerVelocity.x -= (playerSpeed / 10)
		else:
			playerVelocity.x = -playerSpeed
	else:
		if playerVelocity.x > 1 || playerVelocity.x < -1:
			playerVelocity.x = playerVelocity.x / floatDenominator
		else:
			playerVelocity.x = 0
