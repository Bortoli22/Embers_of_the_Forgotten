extends Control



func _ready():
	hide()
	
func _on_back_pressed():
	get_node("../../MenuSFX").play("select2")
	hide()
