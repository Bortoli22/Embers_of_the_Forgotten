extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("Pause/Control").enter_playground_mode() # Replace with function body.

func _exit_tree():
	get_node("Pause/Control").exit_playground_mode()
#func _process(delta):
#	if GameData.playground :
#		get_node("Pause").enter_playground_mode()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
