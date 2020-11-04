extends Area2D
var damageValue = 110
#var damageSweetspot
var force = Vector2(50, -80)
var staggerWindow = 0.2 #x seconds
var noCancel = false
var cancelOffset = 0.06
var animations = ["5AA startup", "5AA active", "5AA recovery"]

func _ready():
	get_parent().remove_child(self)
