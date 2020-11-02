extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func respawn():
	GameData.player_dead = false
	var tree = get_tree() 
	var root = tree.get_root()
	get_parent().remove_child(self)
	self.queue_free()
	
	var stage = root.get_node("Root") 
	if stage == null:
		stage = root.get_node("Main")
		
	tree.current_scene = stage
	tree.reload_current_scene()
	print(GameData.player_dead)
	
