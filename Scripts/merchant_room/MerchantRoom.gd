extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Submit_pressed():
	GameData.current_level += 1
	get_tree().change_scene("res://Scenes/Stage.tscn")
