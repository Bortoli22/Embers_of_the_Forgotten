extends Area2D
var damageValue = 170
var force = Vector2(200, -500)
var staggerWindow = 0.3 #x seconds
var noCancel = true
var cancelOffset = 0
var animations = ["5AAAA startup", "5AAAA active", "5AAAA recovery"]

func _ready():
	get_parent().remove_child(self)
