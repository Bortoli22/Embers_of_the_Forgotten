extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.




func _submit():

	get_tree().change_scene("res://Scenes/Stage.tscn")
	#var parent = get_parent()
	#var root = get_tree().get_root()
	#var level_node = load("res://Scenes/Stage.tscn")
	#root.add_child(level_node.instance())
	#root.remove_child(parent)
	#parent.queue_free()
	
