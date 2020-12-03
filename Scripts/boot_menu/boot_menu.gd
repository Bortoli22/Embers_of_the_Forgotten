extends Node2D

func _ready():
	pass # Replace with function body.




func _on_Start_pressed():
	$MenuSFX.play("select1") #need to do it in the same function otherwise it will pass the timer to another thread
	yield(get_tree().create_timer(0.8), "timeout")
	get_tree().change_scene("res://Scenes/StartMenu.tscn")

func _on_Settings_pressed():
	#consider not changing scenes for this one, since the menu music won't follow 
	buttonsound()
	$SettingsMenu.show()
	

func _on_Quit_pressed():
	$MenuSFX.play("select1")
	yield(get_tree().create_timer(0.8), "timeout")
	get_tree().quit()

func _on_Scoreboard_pressed():
	buttonsound()
	$"./ScoreMenu".loadScores()
	$ScoreMenu.show()

func buttonsound():
	$MenuSFX.play("select1")
