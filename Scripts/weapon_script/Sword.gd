extends Node2D
var moveSequence
var moveCount = 3
var currentPosition
var currentMove
var hit
var active
var wepOrientation
onready var sprite = $Visual
onready var animation = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	currentPosition = -1
	moveSequence = [get_node("5A"),get_node("5AA"),get_node("5AAA"),get_node("5AAAA")]
	remove_child(moveSequence[0])
	sprite.frame = 16
	hit = false
	active = false
	wepOrientation = 1
	PlayerData.wpnactionable = true
	pass # Replace with function body.

#sequence of cancel windows

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if active:
		var x = currentMove.get_overlapping_bodies()
		if (x != []):
			hit = true
			for y in x:
				hit(y)
				print(y)
	if (animation.get_current_animation() == "neutral"):
		PlayerData.playerNode.capSpeed(600)
		currentPosition = -1

#	see if there's a way to more conditionally trigger a delta process.
func attack(orientation):
	hit = false
	if (currentPosition < moveCount):
		if (!PlayerData.playerNode.jump_count > 0 && !PlayerData.playerNode.jumping):
			PlayerData.playerNode.capSpeed(200)
		orient(orientation)
		currentPosition += 1
		currentMove = moveSequence[currentPosition]
		print(currentPosition)
		var tempMove = currentPosition
		animation.play(currentMove.animations[0])
		yield(animation, "animation_finished")
		
		active = true
		animation.play(currentMove.animations[1])
		add_child(moveSequence[tempMove])
		yield(animation, "animation_finished")
		if (!hit):
			remove_child(moveSequence[tempMove])
		animation.play(currentMove.animations[2])
		
		if (moveSequence[tempMove].cancelOffset != 0):
			yield(get_tree().create_timer(moveSequence[tempMove].cancelOffset), "timeout")
			
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
		body.damageHandler(moveSequence[currentPosition].damageValue, wepOrientation, Vector2(100,-100))
	remove_child(moveSequence[0])

func orient(orientation):
	var flip 
	if (orientation):
		flip = wepOrientation*1
	else:
		flip = wepOrientation*-1
	print(flip)
	if (flip != 1):
		transform *= Transform2D.FLIP_X
		#$Visual.set_flip_h(!orientation)
		wepOrientation *= -1
	print(wepOrientation)

func _on_5A_body_entered(body):
	pass
	#hit = true
	#print("hit")
	#remove_child(moveSequence[0])
