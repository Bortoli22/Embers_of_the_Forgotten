extends Node2D


# Declare member variables here. Examples:
var end_goal_x = -1
onready var playerNode = get_node("../Player")

# Called when the node enters the scene tree for the first time.
func _ready():
	end_goal_x = GameData.tile_size * (GameData.final_grid_size_x - 2)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (playerNode.position.x >= end_goal_x) and (GameData.current_level % 4 != 0):
		GameData.current_level += 1
		print(GameData.current_level)
		var exec = get_tree().change_scene("res://Scenes/Stage.tscn")
		if exec != OK:
			print("ERROR LOADING MERCHANT ROOM SCENE")
			return
