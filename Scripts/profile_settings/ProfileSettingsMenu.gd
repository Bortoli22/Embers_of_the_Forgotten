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


func _on_SignInButton_pressed():
	var unEdit = $Control/Panel/SignIn/UserLineEdit
	var pwEdit = $Control/Panel/SignIn/PasswordLineEdit
	var un = unEdit.text
	var pw = pwEdit.text
	var errorLabel = $Control/Panel/SignIn/ErrorLabel
	var db = PlayerData.SQLite.new()
	db.path = "res://data/users"
	db.open_db()
	db.query("SELECT userid FROM users WHERE username = '" + un + "' AND password = '" + pw + "';")
	if db.query_result.size() == 0:
		errorLabel.show()
	else:
		db.query("UPDATE users SET signedin = true WHERE username = '" + un + "';")
		PlayerData.signedin = true
		PlayerData.username = un
		open()
		
	db.close_db()
