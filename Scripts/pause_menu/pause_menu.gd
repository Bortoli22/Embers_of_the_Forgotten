extends Control

var in_playground = false

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()

# Called every frame. 'delta' is the elapsed time since the previous frame
func _process(delta):
	if in_playground: 
		get_node("VBoxContainer/SaveGame").visible = false
		get_node("VBoxContainer/LoadGame").visible = false
		
	if Input.is_action_just_released("pause"):
		get_node("GameSaveMsg").visible = false
		if GameData.paused:
			hide()
			GameData.paused = false
		else:
			GameData.paused = true
			$MenuSFX.play("open")
			show()
			
func enter_playground_mode():
	get_node("VBoxContainer/SaveGame").visible = false
	get_node("VBoxContainer/LoadGame").visible = false
	get_node("VBoxContainer/ControlRebind").visible = false
	
func exit_playground_mode():
	get_node("VBoxContainer/SaveGame").visible = true
	get_node("VBoxContainer/LoadGame").visible = true
	get_node("VBoxContainer/ControlRebind").visible = true
	
func _on_SaveGame_pressed():
	get_node("GameSaveMsg").visible = true # Replace with function body.


func _on_CheckBox_toggled(button_pressed):
	GameData.fullscreen = button_pressed
	OS.window_fullscreen = button_pressed # Replace with function body.


func _on_Resume_pressed():
	buttonsound()

func _on_Restart_pressed():
	buttonsound()

func _on_MainMeu_pressed():
	buttonsound()

func _on_ControlRebind_pressed():
	buttonsound()
	
func buttonsound():
	$MenuSFX.play("select1")
