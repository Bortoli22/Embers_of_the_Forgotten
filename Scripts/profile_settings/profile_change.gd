extends Control

signal un_changed

var currentUnLbl
var newUnEdit
var oldPwEdit
var newPwEdit
var newPw2Edit
var unError
var pwError

func _ready():
	unError = $Panel/UnChange/ErrorLabel
	pwError = $Panel/PwChange/ErrorLabel
	unError.hide()
	pwError.hide()
	hide()

func open():
	currentUnLbl = $Panel/UnChange/CurrentUnLabel
	newUnEdit = $Panel/UnChange/NewUnLineEdit
	oldPwEdit = $Panel/PwChange/OldPwLineEdit
	newPwEdit = $Panel/PwChange/NewPwLineEdit
	newPw2Edit = $Panel/PwChange/NewPw2LineEdit
	currentUnLbl.text = "Username: " + PlayerData.username
	show()


func _on_Close_pressed():
	get_node("../../MenuSFX").play("select2")
	currentUnLbl.text = ""
	newUnEdit.text = ""
	newPwEdit.text = ""
	newPw2Edit.text = ""
	unError.hide()
	pwError.hide()
	hide()


func _on_UnSubmit_pressed():
	get_node("../../MenuSFX").play("open")
	var newUn = newUnEdit.text.strip_edges(true,true)
	if newUn.empty():
		unError.show()
		unError.text = "Username is empty"
		return
	else:
		var db = PlayerData.SQLite.new()
		db.path = "res://data/users"
		db.open_db()
		db.query("SELECT * FROM users WHERE username = '" + newUn + "';")
		if db.query_result.empty():
			db.query("UPDATE users SET username = '" + newUn + "' WHERE username = '" + PlayerData.username + "';")
			currentUnLbl.text = "Username: " + newUn
			PlayerData.username = newUn
			unError.show()
			unError.text = "Username updated"
			emit_signal("un_changed")
		else:
			unError.show()
			unError.text = "Username exists"
		db.close_db()
		


func _on_PwSubmit_pressed():
	get_node("../../MenuSFX").play("open")
	var oldPw = oldPwEdit.text.strip_edges(true,true)
	var newPw = newPwEdit.text.strip_edges(true, true)
	var newPw2 = newPw2Edit.text.strip_edges(true,true)
	
	if oldPw.empty() || newPw.empty() || newPw2.empty():
		pwError.show()
		pwError.text = "Password field(s) empty"
		return
	else:
		if newPw == newPw2:
			var db = PlayerData.SQLite.new()
			db.path = "res://data/users"
			db.open_db()
			db.query("SELECT * FROM users WHERE username = '" + PlayerData.username + "' AND password = '" + oldPw + "';")
			if db.query_result.empty():
				pwError.show()
				pwError.text = "Incorrect password"
			else:
				db.query("UPDATE users SET password = '" + newPw + "' WHERE username = '" + PlayerData.username + "';")
				pwError.show()
				pwError.text = "Password Updated"
			db.close_db()
		else:
			pwError.show()
			pwError.text = "New passwords do not match"
