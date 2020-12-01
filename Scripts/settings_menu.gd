extends Control

func _ready():
	pass # Replace with function body.



func _on_back_pressed():
	get_tree().change_scene("res://Scenes/BootMenu.tscn")


func _on_Button_pressed():
	OS.window_fullscreen = !OS.window_fullscreen
