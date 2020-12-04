extends Node


# Declare member variables here. Examples:
onready var defaultSkin = load("res://Assets/Player_Character_Animations.png")
onready var altSkin = load("res://Assets/Alt_Player_Character_Animations.png")


# Called when the node enters the scene tree for the first time.
func _ready():
	_changeSkin(PlayerData.skin) # Replace with function body.

func _changeSkin(skin):

	if skin == "alt":
		get_parent().texture = altSkin
	elif skin == "default":
		get_parent().texture = defaultSkin
	else:
		return
	PlayerData.skin = skin
