extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	pass # Replace with function body.


func respawn():
	#print("gothere")
	show()
	

func _on_Button_pressed():
	GameData.player_dead = false
	GameData.paused = false
	
	PlayerData.abilities = []
	PlayerData.weapons = []
	PlayerData.equipped = []
	GameData.current_level = 1
	PlayerData.playerHealth = PlayerData.playerHealthMax
	PlayerData.currency = 0
	hide()
	
	get_tree().change_scene("res://Scenes/StartMenu.tscn")


func _on_Menu_pressed():
	GameData.player_dead = false
	GameData.paused = false
	
	PlayerData.abilities = []
	PlayerData.weapons = []
	PlayerData.equipped = []
	GameData.current_level = 1
	PlayerData.currency = 0
	PlayerData.playerHealth = PlayerData.playerHealthMax
	hide()
	get_tree().change_scene("res://Scenes/BootMenu.tscn")
