extends Node2D

var damageValue = -200
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_hitbox_body_entered(body):
	if body.has_method("damageHandler"):
		body.damageHandler(damageValue, -1)
