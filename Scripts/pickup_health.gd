extends RigidBody2D

var value = 50
var xvelocity = 0
var type = "health"


# Called when the node enters the scene tree for the first time.
func _ready():
	set_axis_velocity(Vector2(xvelocity, -200))

func init(num, xvel):
	value = num
	xvelocity = xvel

func use():
	queue_free()
