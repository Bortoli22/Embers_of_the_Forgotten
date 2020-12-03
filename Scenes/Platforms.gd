extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export (Array, NodePath) onready var platforms_nodepaths

# Called when the node enters the scene tree for the first time.
func _ready():
	for N in get_children():
		platforms_nodepaths.push_front(N.get_path())
	 # Replace with function body.

func	 is_body_platform(body):
	return platforms_nodepaths.has(body.get_path())

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
