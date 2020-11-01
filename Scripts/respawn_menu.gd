extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func respawn():
	GameData.player_dead = false
	var root = get_tree().get_root()
	root.remove_child(self)
	self.queue_free()
	
