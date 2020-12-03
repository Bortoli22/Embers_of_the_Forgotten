extends Button

func _ready():
	pass
	
func _on_MainMeu_pressed():
	GameData.paused = false
	get_tree().change_scene("res://Scenes/BootMenu.tscn")
