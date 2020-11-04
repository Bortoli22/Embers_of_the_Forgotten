extends Node


var paused = false
var player_dead = false
var main_node
var final_grid_size_x = -1
var current_level = 1
var tile_size = 32
const WPN_SPEAR = ""
const WPN_SWORD = ""
const WPN_SCYTHE = ""

#the possible unlocks, aka what the player doesn't have yet
var merchantPool = [
	"double jump",
	#"dash", to be implemented?
	"triple jump",
	"wall jump",
	"dodge",
	"sword",
	"spear",
	"scythe"
]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
