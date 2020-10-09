extends Node2D
var healthValue = 400
var damageValue = 200
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func behaviorCore():
	pass

#func behaviorPattern1():
	#pass
	
#func behaviorPattern2():
	#pass
	
#func behaviorPattern3():
	#pass

func damageHandler(damage):
	healthValue -= damageValue

func died():
	drops()
	queue_free()

func drops():
	pass
	

func _on_hitbox_body_entered(body):
	if body.has_method("damageHandler"):
		body.damageHandler(damageValue, -1)
