extends RigidBody2D
var chunkrect
var rng = RandomNumberGenerator.new()

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	var impulseY = rng.randi_range(-200, 0)
	var impulseA = rng.randf_range(-9, 9)
	self.linear_velocity = Vector2(0, impulseY)
	self.angular_velocity = impulseA
	pass # Replace with function body.
	
func _process(delta):
	if (delta > 300):
		queue_free()

func init(pos, size):
	get_node("chunkrect").set_size(size)
	self.transform.origin = Vector2(pos, self.transform.origin.y)
