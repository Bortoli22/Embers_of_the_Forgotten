extends RigidBody2D

var value = 1
var xvelocity = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	set_axis_velocity(Vector2(xvelocity, -200))
	

func init(num, xvel):
	value = num
	xvelocity = xvel
	
func _on_PickupTrigger_area_entered(area):
	if area.has_method("add_money"):
		area.add_money(value)
		queue_free()
