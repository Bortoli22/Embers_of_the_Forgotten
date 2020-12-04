extends Control

var unEdit = null
var pwdEdit = null
var rpwdEdit = null
var errorlabel = null
var successPanel = null

func _ready():
	unEdit = $Panel/VBoxContainer/UsernameLineEdit
	pwdEdit = $Panel/VBoxContainer/PasswordLineEdit
	rpwdEdit = $Panel/VBoxContainer/ReenterPasswordLineEdit
	errorlabel = $Panel/VBoxContainer/ErrorLabel
	successPanel = $Panel/SuccessPanel
	
	errorlabel.hide()
	successPanel.hide()
	hide()

func _on_Create_pressed():
	get_node("../../MenuSFX").play("select2")
	var un = unEdit.text
	var pw = pwdEdit.text
	var rpw = rpwdEdit.text
	
	if un.length() == 0:
		errorlabel.text = "Username empty"
		errorlabel.show()
		return
	if pw.length() == 0 || rpw.length() == 0:
		errorlabel.text = "Password field(s) empty"
		errorlabel.show()
		return
	if pw != rpw:
		errorlabel.text = "Passwords don't match"
		errorlabel.show()
		return
		
	var db = PlayerData.SQLite.new()
	db.path = "res://data/users"
	db.open_db()
	db.query("SELECT COUNT(*) as cnt FROM users WHERE username ='" + un + "';")
	if db.query_result[0]["cnt"] == 0:
		var row : Dictionary  = Dictionary()
		
		db.query("SELECT MAX(userid) maxid FROM users;")
		if str(db.query_result[0]["maxid"]) == "":
			row["userid"] = 0
		else:
			row["userid"] = db.query_result[0]["maxid"] + 1		
			
		row["username"] = un
		row["password"] = pw
		row["signedin"] = false
		db.insert_row("users", row)
		successPanel.show()
	else:
		errorlabel.text = "Username already taken"
		errorlabel.show()
	db.close_db()
	
func _on_Close_pressed():
	get_node("../../MenuSFX").play("select2")
	unEdit.text = ""
	pwdEdit.text = ""
	rpwdEdit.text = ""
	errorlabel.hide()
	$Panel/SuccessPanel.hide()
	hide()


func _on_Back_pressed():
	get_node("../../MenuSFX").play("select2")
	unEdit.text = ""
	pwdEdit.text = ""
	rpwdEdit.text = ""
	errorlabel.hide()
	hide()
