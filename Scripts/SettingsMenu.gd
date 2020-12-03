extends Control

func _ready():
	hide()


func _on_VolumeSettingsButton_pressed():
	$VolumeSettings.open()

func _on_ControlSettingsButton_pressed():
	$ControlRebindMenu/Control.show()

func _on_ProfileSettingMenu_pressed():
	$ProfileSettingsMenu.open()
	
func _on_Close_pressed():
	hide()

func _on_FuilScreen_pressed():
	OS.window_fullscreen = !OS.window_fullscreen
