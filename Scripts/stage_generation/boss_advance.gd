extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("AnimatedSprite").visible = false
	spawnEnemies()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if GameData.current_level % 4 == 0 and GameData.roomEnemyCount <= 0:
		get_node("AnimatedSprite").visible = true

func spawnEnemies():
	pass

func _on_Area2D_area_entered(area):
	if (GameData.current_level % 4 != 0) or (GameData.roomEnemyCount > 0):
		return
	var exec = get_tree().change_scene("res://Scenes/MerchantRoom.tscn")
	if exec != OK:
		print("ERROR LOADING MERCHANT ROOM SCENE")
		return
