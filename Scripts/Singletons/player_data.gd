extends Node
const DIRECTION_RIGHT = 1
const DIRECTION_LEFT = -1
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

# Called when the node enters the scene tree for the first time.
func _ready():
	playerHealth = playerHealthMax
	rangedUnlocks[0] = true
	#rangedUnlocks[1] = true
	#rangedUnlocks[2] = true
	wpnactionable = true
	orientation = 1
	PlayerData.add_to_group("Persist", true)
	

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
		"wpnactionable" : wpnactionable
	}
	return save_dict
	
