extends Button

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_restart_pressed():
	GameData.paused = false
	var pause_menu = get_parent().get_parent()
	var tree = get_tree()
	var root = tree.get_root()
	var stage = root.get_node("Root")
	if stage == null:
		stage = root.get_node("Main")
	
	root.remove_child(pause_menu)
	pause_menu.queue_free()
	root.remove_child(stage)
	stage.queue_free()
	
	PlayerData.abilities = []
	PlayerData.weapons = []
	GameData.current_level = 1
	var start_menu = load("res://Scenes/StartMenu.tscn")
	root.add_child(start_menu.instance())
	
