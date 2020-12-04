extends Node

var fullscreen
var playground = false

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
var interactablePos = []
var roomEnemyCount = 0

var MasterVol
var BGMVol
var SFXVol

var stage_tile_set
var stage_parent

var loaded

var bossRoomFinished = false
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

#the lookup table for the prices of unlocks, should only be accessed not editted
var merchantPrices = {
	"double jump": 300,
	"triple jump": 1000,
	"dash": 100,
	"wall jump": 400,
	"dodge": 100,
	"sword": 500,
	"spear": 700,
	"scythe": 600,
	"fireball": 500,
	"firewave": 800
}

# Called when the node enters the scene tree for the first time.
func _ready():
	GameData.fullscreen = OS.window_fullscreen
	GameData.add_to_group("Persist", true) # Replace with function body.
 # Replace with function body.
	
func save():
	
	var save_dict = {
		"name" : "GameData",
		"parent"	   : get_parent().get_path(),
		#"paused" : paused,
		"player_dead" : player_dead,
		#"main_node" : main_node,
		"camera_node" : camera_node,
		"final_grid_sixe_x" : final_grid_size_x,
		"current_level" : current_level as int,
		"tile_size" : tile_size,
		"playground" : playground,
		"fullscreen" : fullscreen,
		
	}
	return save_dict
	
func loadValues():
	current_level = current_level as int
