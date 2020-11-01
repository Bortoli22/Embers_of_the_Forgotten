extends Node

#I haven't used these anywhere, just giving you an idea of what to add
var playerHealth
var playerHealthMax = 1000
var itemsfound = null
var abilities = []
var weapons = []

# Called when the node enters the scene tree for the first time.
func _ready():
	playerHealth = playerHealthMax	
	
func check_abilities(ability):
	return abilities.find(ability) >= 0
