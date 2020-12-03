extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var save_nodes_index = 0

var autosaved = false

const autosave_msg_time = 0.2

var time = 0
signal timeout

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func _process(delta):
	if !autosaved :
		return
		
	
		
func autosave():
	autosaved = true
	save()

func save():
	save_nodes_index = 0
	var save_game = File.new()
	save_game.open("user://savegame.json", File.WRITE)
	

	var save_nodes = get_tree().get_nodes_in_group("Persist")
	
	#save_game.store_line("[")
	for node in save_nodes:
		
		# Check the node is an instanced scene so it can be instanced again during load.        	if node.filename.empty():
		#print("persistent node '%s' is not an instanced scene, skipped" % node.name)
		#continue

		# Check the node has a save function.
		if !node.has_method("save"):
			print("persistent node '%s' is missing a save() function, skipped" % node.name)
			continue

		# Call the node's save function.
		var node_data = node.call("save")

		# Store the save dictionary as a new line in the save file.
		save_game.store_line(to_json(node_data))
		
		#if save_nodes_index < save_nodes.size()-1 :
		#	save_game.store_line(",")
		save_nodes_index += 1
	#save_game.store_line("]")
	
	save_game.close()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
