extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var interactable = preload("res://Scenes/Interactable.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _place_interactables():
	for val in GameData.interactablePos:
		var addInter = interactable.instance()
		addInter.position.x = val.x
		addInter.position.y = val.y
		add_child(addInter)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
