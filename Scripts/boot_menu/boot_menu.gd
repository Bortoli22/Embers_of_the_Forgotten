extends Node2D

func _ready():
	pass # Replace with function body.




func _on_Start_pressed():
	get_tree().change_scene("res://Scenes/StartMenu.tscn")


func _on_Settings_pressed():
	get_tree().change_scene("res://Scenes/SettingsMenu.tscn")


func _on_Quit_pressed():
	get_tree().quit()