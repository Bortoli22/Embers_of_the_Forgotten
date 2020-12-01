extends CanvasLayer
var MASBus
var BGMBus
var SFXBus

func _ready():
	MASBus = AudioServer.get_bus_index("Master")
	BGMBus = AudioServer.get_bus_index("BGM")
	SFXBus = AudioServer.get_bus_index("SFX")
	$Window.hide()

func open():
	$Window/VBoxContainer/MasterSlider.value = AudioServer.get_bus_volume_db(MASBus)
	$Window/VBoxContainer/BGMSlider.value = AudioServer.get_bus_volume_db(BGMBus)
	$Window/VBoxContainer/SFXSlider.value = AudioServer.get_bus_volume_db(SFXBus)
	$Window/VBoxContainer/Master/MMute.pressed = AudioServer.is_bus_mute(MASBus)
	$Window/VBoxContainer/BGM/BMute.pressed = AudioServer.is_bus_mute(BGMBus)
	$Window/VBoxContainer/SFX/SMute.pressed = AudioServer.is_bus_mute(SFXBus)
	$Window.show()
	
func close():
	$Window.hide()
	

func _on_MMute_toggled(button_pressed):
	AudioServer.set_bus_mute(MASBus, button_pressed)


func _on_BMute_toggled(button_pressed):
	AudioServer.set_bus_mute(BGMBus, button_pressed)


func _on_SMute_toggled(button_pressed):
	AudioServer.set_bus_mute(SFXBus, button_pressed)


func _on_MasterSlider_value_changed(value):
	AudioServer.set_bus_volume_db(MASBus, value)


func _on_SFXSlider_value_changed(value):
	AudioServer.set_bus_volume_db(SFXBus, value)


func _on_BGMSlider_value_changed(value):
	AudioServer.set_bus_volume_db(BGMBus, value)


func _on_Back_pressed():
	close()
