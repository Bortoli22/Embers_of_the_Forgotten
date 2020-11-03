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
	moveSequence = [get_node("5A"),get_node("5AA"),get_node("5A"),get_node("5A")]
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
		currentPosition = -1

#	see if there's a way to more conditionally trigger a delta process.
func attack(orientation):
	hit = false
	if (currentPosition < moveCount):
		orient(orientation)
		currentMove = moveSequence[currentPosition]
		currentPosition += 1
		print(currentPosition)
		var tempMove = currentPosition
		animation.play("5A startup")
		yield(animation, "animation_finished")
		
		active = true
		animation.play("5A active")
		add_child(moveSequence[tempMove])
		yield(animation, "animation_finished")
		if (!hit):
			remove_child(moveSequence[tempMove])
		
		animation.play("5A recovery")
		PlayerData.wpnactionable = true
		yield(get_tree().create_timer(moveSequence[tempMove].staggerWindow), "timeout") #uneasy
		if (tempMove == currentPosition):
			currentPosition = -1
			PlayerData.wpnactionable = true

func hit(body):
	print("hit")
	if (body.has_function("damageHandler")):
		body.damageHandler(moveSequence[currentPosition].damageValue, wepOrientation, Vector2(100,-100))
	remove_child(moveSequence[0])

func orient(orientation):
	var flip 
	if (orientation):
		flip = wepOrientation*1
	else:
		flip = wepOrientation*-1
	if (flip != 1):
		transform *= Transform2D.FLIP_X
		$Visual.set_flip_h(!orientation)
		wepOrientation *= -1
	print(wepOrientation)

func _on_5A_body_entered(body):
	pass
	#hit = true
	#print("hit")
	#remove_child(moveSequence[0])
