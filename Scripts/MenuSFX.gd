extends Node
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func play(sfx):
	get_node(sfx).play()
