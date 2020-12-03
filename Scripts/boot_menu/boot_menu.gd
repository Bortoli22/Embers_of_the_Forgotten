extends Node2D

func _ready():
	pass # Replace with function body.




func _on_Start_pressed():
	get_tree().change_scene("res://Scenes/StartMenu.tscn")


func _on_Settings_pressed():
	#consider not changing scenes for this one, since the menu music won't follow 
	$SettingsMenu.show()
	


func _on_Quit_pressed():
	get_tree().quit()
