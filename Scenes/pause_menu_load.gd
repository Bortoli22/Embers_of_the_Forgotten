extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass



func _on_LoadGame_pressed():
	load_game() # Replace with function body.

func load_game():
	
	var save_game = File.new()
	if not save_game.file_exists("user://savegame.json"):
		return # Error! We don't have a save to load.

	# We need to revert the game state so we're not cloning objects
	# during loading. This will vary wildly depending on the needs of a
	# project, so take care with this step.
	# For our example, we will accomplish this by deleting saveable objects.
	#var save_nodes = get_tree().get_nodes_in_group("Persist")
	#for i in save_nodes:
		#i.queue_free()

	# Load the file line by line and process that dictionary to restore
	# the object it represents.
	save_game.open("user://savegame.json", File.READ)
	while save_game.get_position() < save_game.get_len():
		# Get the saved dictionary from the next line in the save file
		var node_data = parse_json(save_game.get_line())

		# Firstly, we need to create the object and add it to the tree and set its position.
		#var new_object = load(node_data["name"]).instance()
		#get_node(node_data["parent"]).add_child(new_object)
		#new_object.position = Vector2(node_data["pos_x"], node_data["pos_y"])
		var load_node
		if node_data["name"] == "PlayerData":
			load_node = PlayerData
		elif node_data["name"] == "GameData":
			load_node = GameData
			GameData.loaded = true
		else :
			load_node = get_node(node_data["path"])
		# Now we set the remaining variables.
		for i in node_data.keys():
			if i == "name" or i == "parent" or i == "path": #or i == "pos_x" or i == "pos_y":
				continue
			else :
				load_node.set(i, node_data[i])
		
		#new_object.Singleton = true
		
	save_game.close()
	OS.window_fullscreen = GameData.fullscreen
	GameData.paused = false
	
	var exec = get_tree().change_scene("res://Scenes/Stage.tscn")
	if exec != OK:
		print("ERROR SWITCHING FROM MAIN MENU TO STAGE")
	return 
