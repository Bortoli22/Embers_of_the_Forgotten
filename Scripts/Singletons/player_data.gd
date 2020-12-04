extends Node
const DIRECTION_RIGHT = 1
const DIRECTION_LEFT = -1
const SQLite = preload("res://addons/godot-sqlite/bin/gdsqlite.gdns")
var playerNode #thank god
var playerHealth
var playerHealthMax = 1000
var currency = 0
var itemsfound = null
var abilities = []
var weapons = []
var ranged = ["pistol", "smg", "sniper"]
var rangedUnlocks = [false, false, false]
var scores = [0, 0, 0, 0, 0]
#var scores = [9999, 9999, 9999, 9999, 9999]
var orientation #rightness
var baseATK
var equipped = []
var wpnslot1 = null
var wpnslot2 = null
var wpnactionable
var skin = "default"
var signedin = false
var username = ""

var availableSkins = ["default", "alt"]
# Called when the node enters the scene tree for the first time.
func _ready():
	playerHealth = playerHealthMax
	currency = 0
	rangedUnlocks[0] = true
	#rangedUnlocks[1] = true
	#rangedUnlocks[2] = true
	wpnactionable = true
	orientation = 1
	PlayerData.add_to_group("Persist", true)
	signedin = signin_check()
	

func check_abilities(ability):
	return abilities.find(ability) >= 0
	
func grant_all_abilities():
	abilities.append("double jump")
	abilities.append("triple jump")
	abilities.append("dash")
	abilities.append("wall jump")
	abilities.append("dodge")
	
func remove_all_abilities():
	abilities.clear()
	
func save():
	
	var save_dict = {
		"name" : "PlayerData",
		"parent"	   : get_parent().get_path(),
		"player_health" : playerHealth,
		"currency" : currency,
		"items_found" : itemsfound,
		"abilities" : abilities,
		"weapons" : weapons,
		"baseATK" : baseATK,
		"wpnslot1" : wpnslot1,
		"wpslot2" : wpnslot2,
		"wpnactionable" : wpnactionable,
		"skin" : skin
	}
	return save_dict

func loadSkin() :
	pass

func signin_check():
	var db = SQLite.new()
	db.path = "res://data/users"
	db.open_db()
	db.query("SELECT name FROM sqlite_master WHERE type='table' AND name='users';")
	if db.query_result.size() == 0:
		#create table
		var table_dict : Dictionary = Dictionary()
		table_dict["userid"] = {"data_type":"int", "primary_key": true, "not_null": true}
		table_dict["username"] = {"data_type":"text", "not_null": true}
		table_dict["password"] = {"data_type":"char(50)"}
		table_dict["signedin"] = {"data_type":"boolean"}
		db.create_table("users", table_dict)
		db.query("SELECT name FROM sqlite_master WHERE type='table' AND name = 'users';")
		print(db.query_result)
		db.close_db()
		return false
	else:
		#query table for signed in user
		#if signed in, return true and set user name
		db.query("SELECT username FROM users WHERE signedin=true;")
		if db.query_result.size() == 0: 
			db.close_db()
			return false
		username = db.query_result[0]["username"]
		db.close_db()
		return true
