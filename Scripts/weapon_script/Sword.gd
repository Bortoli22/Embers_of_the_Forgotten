extends Node2D
var moveSequence
var moveCount = 4
var currentMove
var hit
var active
onready var sprite = $Visual
onready var animation = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	currentMove = -1
	moveSequence = [get_node("5A")]
	remove_child(moveSequence[0])
	sprite.frame = 16
	hit = false
	active = false
	PlayerData.wpnactionable = true
	pass # Replace with function body.

#sequence of cancel windows

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if active:
		var x = moveSequence[0].get_overlapping_bodies()
		if (x != []):
			for y in x:
				print(y)
			hit()
	

#	see if there's a way to more conditionally trigger a delta process.
func attack():
	hit = false
	if (currentMove < moveCount):
		print(currentMove)
		animation.play("5A startup")
		yield(get_node("AnimationPlayer"), "animation_finished")
		active = true
		animation.play("5A active")
		add_child(moveSequence[0])
		yield(get_node("AnimationPlayer"), "animation_finished")
		if (!hit):
			remove_child(moveSequence[0])
		animation.play("5A recovery")
		PlayerData.wpnactionable = true

func hit():
	hit = true
	print("hit")
	remove_child(moveSequence[0])

func _on_5A_body_entered(body):
	pass
	#hit = true
	#print("hit")
	#remove_child(moveSequence[0])
