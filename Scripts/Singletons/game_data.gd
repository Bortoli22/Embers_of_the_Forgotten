extends Node


var paused = false
var player_dead = false
var main_node
var camera_node
var final_grid_size_x = -1
var current_level = 1
var tile_size = 32
const WPN_SPEAR = ""
const WPN_SWORD = ""
const WPN_SCYTHE = ""
const HEAVYSHAKE = 40
const MEDIUMSHAKE = 8
const LIGHTSHAKE = 5

#the possible unlocks, aka what the player doesn't have yet
var merchantPool = [
	"double jump",
	"triple jump",
	"dash",
	"wall jump",
	"dodge",
	"sword",
	"spear",
	"scythe",
	"fireball",
	"firewave"
]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
