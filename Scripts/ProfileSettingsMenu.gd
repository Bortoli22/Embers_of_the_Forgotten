extends CanvasLayer


func _ready():
	$Control.hide()

func open():
	$Control.show()

func _on_Back_pressed():
	$Control.hide()
