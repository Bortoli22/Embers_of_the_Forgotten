extends Node
const DIRECTION_RIGHT = 1
const DIRECTION_LEFT = -1
var playerNode #thank god
var playerHealth
var playerHealthMax = 1000
var currency = 0
var itemsfound = null
var abilities = []
var ranged = ["pistol", "smg", "sniper"]
var rangedUnlocks = [false, false, false]
var orientation #rightness
var baseATK
var wpnslot1
var wpnslot2
var wpnactionable

# Called when the node enters the scene tree for the first time.
func _ready():
	playerHealth = playerHealthMax
	rangedUnlocks[0] = true
	rangedUnlocks[1] = true
	rangedUnlocks[2] = true
	wpnactionable = true
	orientation = 1
	
func check_abilities(ability):
	return abilities.find(ability) >= 0
