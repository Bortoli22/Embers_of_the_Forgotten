extends Node2D
var projectile = preload("res://Scenes/projectile.tscn")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func attack():
	var p = projectile.instance() #The actual projectile object in the scene.
	p.transform = PlayerData.playerNode.get_transform()
	get_tree().get_root().add_child(p)
	yield(get_tree().create_timer(0.5), "timeout")
	PlayerData.wpnactionable = true
