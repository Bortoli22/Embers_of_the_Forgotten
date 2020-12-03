extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_PlaygroundButton_pressed():
	
	var exec = get_tree().change_scene("res://Scenes/Playground.tscn")
	if exec != OK:
		print("ERROR SWITCHING FROM MAIN MENU TO STAGE")
	#PlayerData.grant_all_abilities()
	GameData.playground = true
	return  # Replace with function body.
