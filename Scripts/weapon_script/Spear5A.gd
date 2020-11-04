extends Area2D
var damageValue = 250
var force = Vector2(50, 100)
var staggerWindow = 0.2 #x seconds
var noCancel = true
var cancelOffset = 0
var animations = ["5A startup", "5A active", "5A recovery"]

func _ready():
	get_parent().remove_child(self)
