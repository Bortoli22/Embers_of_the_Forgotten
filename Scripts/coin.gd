extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var value = 1


# Called when the node enters the scene tree for the first time.
func _ready():
	set_axis_velocity(Vector2(0,500))
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_PickupRange_area_entered(area):
	if area.has_method("add_money"):
		area.add_money(value)
		queue_free()
	
