extends Control

func _ready():
	hide()


func _on_VolumeSettingsButton_pressed():
	$MenuSFX.play("open")
	$VolumeSettings.open()

func _on_ControlSettingsButton_pressed():
	$MenuSFX.play("open")
	$ControlRebindMenu/Control.show()

func _on_ProfileSettingMenu_pressed():
	$MenuSFX.play("open")
	$ProfileSettingsMenu.open()
	
func _on_Close_pressed():
	$MenuSFX.play("select2")
	hide()

func _on_FuilScreen_pressed():
	$MenuSFX.play("select2")
	OS.window_fullscreen = !OS.window_fullscreen
