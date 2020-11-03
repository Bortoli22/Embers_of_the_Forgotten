extends Area2D
var damageValue = 110
var force = Vector2(200, 400)
var staggerWindow = 0.1 #x seconds
var noCancel = false
var cancelOffset = 0.06 #would've liked this to function more like a buffer but oh well
var animations = ["5AAA startup", "5AAA active", "5AAA recovery"]


func _ready():
	get_parent().remove_child(self)
