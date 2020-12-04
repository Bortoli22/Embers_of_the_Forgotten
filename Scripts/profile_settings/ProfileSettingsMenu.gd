extends CanvasLayer


func _ready():
	$Control.hide()

func open():
	$Control.show()
	if PlayerData.signedin:
		$Control/Panel/ProfileInfo/Label.text = "Username: " + PlayerData.username
		$Control/Panel/ProfileInfo.show()
		$Control/Panel/SignIn.hide()
	else:
		$Control/Panel/ProfileInfo.hide()
		$Control/Panel/SignIn.show()

func _on_Back_pressed():
	$Control.hide()


func _on_AccountButton_pressed():
	$ProfileCreate.show()
