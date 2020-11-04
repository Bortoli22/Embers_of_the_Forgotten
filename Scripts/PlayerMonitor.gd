extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var end_goal_x = -1
onready var playerNode = get_node("../Player")

# Called when the node enters the scene tree for the first time.
func _ready():
	end_goal_x = GameData.tile_size * (GameData.final_grid_size_x - 2)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if playerNode.position.x >= end_goal_x:
		get_tree().change_scene("res://Scenes/MerchantRoom.tscn")
