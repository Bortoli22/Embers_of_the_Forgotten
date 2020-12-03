extends StaticBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export onready var collision_shape_path
# Called when the node enters the scene tree for the first time.
func _ready():
	for N in get_children():
		if N is CollisionShape2D:
			collision_shape_path = N.get_path() # Replace with function body.

func get_collision_shape():
	return collision_shape_path
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
