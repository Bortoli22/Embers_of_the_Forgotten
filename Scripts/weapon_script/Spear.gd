extends Node2D
var wpnslot = -1
var action = ""

#moveset control
var moveCount = 1
var currentPosition = -1
var currentMove

#move control
var connected = false
var active = false
var wepOrientation

#for charge moves
var chargeable = false
var charging = false
var negEdge = false

#node references
onready var sprite = $Visual
onready var animation = $AnimationPlayer
onready var moveSequence = [get_node("5A"),get_node("5AA")]

# not started yet
# heavy commital stabs
# can throw the spear as a charge attack 

# Called when the node enters the scene tree for the first time.
func _ready():
	sprite.frame = 11
	wepOrientation = 1
	for node in moveSequence:
		remove_child(node)
	PlayerData.wpnactionable = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if charging && Input.is_action_just_released(get_action()):
		negEdge = true
	if active:
		var x = currentMove.get_overlapping_bodies()
		if (x != []):
			connected = true
			for y in x:
				hit(y)
	if (animation.get_current_animation() == "neutral"):
		PlayerData.playerNode.capSpeed(600)
		currentPosition = -1

#	see if there's a way to more conditionally trigger a delta process.
func attack(orientation):
	connected = false
	if (currentPosition < moveCount):
		if (charging && !negEdge):
			pass
		else:
			charging = true
		if (!PlayerData.playerNode.jump_count > 0 && !PlayerData.playerNode.jumping):
			PlayerData.playerNode.capSpeed(200)
		orient(orientation)
		currentPosition += 1
		currentMove = moveSequence[currentPosition]
		$sfx.play(0.1)
		var tempMove = currentPosition
		animation.play(currentMove.animations[0])
		yield(animation, "animation_finished")
		
		active = true
		animation.play(currentMove.animations[1])
		add_child(currentMove)
		yield(animation, "animation_finished")
		if (!connected):
			remove_child(moveSequence[tempMove])
		animation.play(currentMove.animations[2])
		
		#if (moveSequence[tempMove].cancelOffset != 0):
			#playerData.buffer = 
			
		if (!moveSequence[tempMove].noCancel):
			PlayerData.wpnactionable = true
			PlayerData.playerNode.capSpeed(600)
			if (moveSequence[tempMove].staggerWindow != 0):
				yield(get_tree().create_timer(moveSequence[tempMove].staggerWindow), "timeout") #uneasy
		else:
			yield(animation, "animation_finished")
			
	
		if (tempMove == currentPosition):
			currentPosition = -1
			PlayerData.playerNode.capSpeed(600)
			PlayerData.wpnactionable = true

func hit(body):
	if (body.has_method("damageHandler")):
		body.damageHandler(currentMove.damageValue, wepOrientation, currentMove.force)
	remove_child(currentMove)
	

func ICRoutine():
	pass

func orient(orientation):
	var flip 
	if (orientation):
		flip = wepOrientation*1
	else:
		flip = wepOrientation*-1
	if (flip != 1):
		transform *= Transform2D.FLIP_X
		#$Visual.set_flip_h(!orientation)
		wepOrientation *= -1

func get_action():
	if (action == ""):
		if (wpnslot > -1):
			if (wpnslot == 1):
				action = "pr_fire"
			elif (wpnslot == 2):
				action = "alt_fire"
	return action
