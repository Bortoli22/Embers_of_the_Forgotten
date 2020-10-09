extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.


func change_health(amount):
		get_node("HealthBar").get_node("HealthGreen").change(amount)
	
func die():
	pass
