extends Button

func _ready():
	pass
	
func _on_MainMeu_pressed():
	get_tree().change_scene("res://Scenes/BootMenu.tscn")
