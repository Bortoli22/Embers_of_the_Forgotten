extends RigidBody2D
var chunkrect

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func _process(delta):
	if (delta > 300):
		queue_free()

func init(pos, size):
	get_node("chunkrect").set_size(size)
