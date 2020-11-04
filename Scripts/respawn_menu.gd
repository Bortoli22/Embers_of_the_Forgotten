extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	pass # Replace with function body.


func respawn():
	print("gothere")
	show()
	

func _on_Button_pressed():
	GameData.player_dead = false
	GameData.paused = false
	#var tree = get_tree() 
	#var root = tree.get_root()
	#get_parent().remove_child(self)
	#self.queue_free()
	
	#var stage = root.get_node("Root") 
	#if stage == null:
	#	stage = root.get_node("Main")
		
	#tree.current_scene = stage
	#tree.reload_current_scene()
	
	PlayerData.abilities = []
	PlayerData.weapons = []
	GameData.current_level = 1
	PlayerData.playerHealth = PlayerData.playerHealthMax
	hide()
	
	get_tree().change_scene("res://Scenes/StartMenu.tscn")
