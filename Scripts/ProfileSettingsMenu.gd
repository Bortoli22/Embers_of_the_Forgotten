extends CanvasLayer


func _ready():
	$Control.hide()

func open():
	$Control.show()

func _on_Back_pressed():
	get_node("../MenuSFX").play("select2")
	$Control.hide()
