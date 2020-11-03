extends Node
const DIRECTION_RIGHT = 1
const DIRECTION_LEFT = -1
#I haven't used these anywhere, just giving you an idea of what to add
var playerNode #thank god
var playerHealth
var playerHealthMax = 1000
var currency = 0
var itemsfound = null
var abilities = []
var weapons = []
var orientation #rightness
var baseATK
var wpnslot1
var wpnslot2
var wpnactionable

# Called when the node enters the scene tree for the first time.
func _ready():
	playerHealth = playerHealthMax
	wpnactionable = true
	orientation = 1
	
func check_abilities(ability):
	return abilities.find(ability) >= 0
