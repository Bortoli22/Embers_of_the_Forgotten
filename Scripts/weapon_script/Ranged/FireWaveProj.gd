extends KinematicBody2D

var movement = 1500
var damageValue = 200
var orientation = 1
var force = Vector2(400, -120) #
var velocity
var active
var connected
var fall
var det = false
var currentMove
onready var sprite = $Sprite
onready var moveSequence = [get_node("Hitbox"),get_node("Hitbox2"),get_node("Hitbox3")]

# Called when the node enters the scene tree for the first time.
func _ready():
	sprite.frame = 11
	velocity = Vector2(movement*orientation, 0)
	for node in moveSequence:
		remove_child(node)
	yield(get_tree().create_timer(0.18), "timeout")
	velocity = Vector2(0,4000)
	fall = true
	yield(get_tree().create_timer(0.3), "timeout")
	if !det:
		velocity.x -= orientation*100

func _process(_delta):
	#if (position.x < 10*orientation):
	if (fall && $vCollision.get_overlapping_bodies() != []):
		fall = false
		burst()

func hit(body):
	if (body.has_method("damageHandler")):
		print(body)
		body.damageHandler(currentMove.damageValue, orientation, currentMove.force)

func _physics_process(_delta):
	var _MASret = move_and_slide(velocity)

func burst():
	det = true
	currentMove = moveSequence[0]
	var x
	$sfx.play()
	$AnimationPlayer.play("burst")
	GameData.camera_node.shake(GameData.LIGHTSHAKE, 0.15)
	add_child(currentMove)
	yield(get_tree().create_timer(0.04), "timeout")
	x = currentMove.get_overlapping_bodies()
	if (x != []):
		connected = true
		for y in x:
			hit(y)
	remove_child(currentMove)
	yield(get_tree().create_timer(0.04), "timeout")
	connected = false
	
	currentMove = moveSequence[1]
	add_child(currentMove)
	yield(get_tree().create_timer(0.04), "timeout")
	x = currentMove.get_overlapping_bodies()
	if (x != []):
		connected = true
		for y in x:
			hit(y)
	remove_child(currentMove)
	yield(get_tree().create_timer(0.04), "timeout")
	connected = false
	
	currentMove = moveSequence[2]
	add_child(currentMove)
	yield(get_tree().create_timer(0.04), "timeout")
	x = currentMove.get_overlapping_bodies()
	if (x != []):
		connected = true
		for y in x:
			hit(y)
	remove_child(currentMove)
	yield(get_tree().create_timer(0.04), "timeout")
	connected = false
	yield(get_tree().create_timer(0.08), "timeout")
	queue_free()
