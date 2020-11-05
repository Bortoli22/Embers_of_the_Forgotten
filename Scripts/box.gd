extends RigidBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func damageHandler(damage, direction, force):
	knockback(direction, force)
	

func knockback(direction, force):
	apply_central_impulse(Vector2(force.x*direction, force.y))
	#apply_central_impulse(force)
