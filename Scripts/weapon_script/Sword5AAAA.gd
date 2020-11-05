extends Area2D
var damageValue = 110
var force = Vector2(30, -200)
var staggerWindow = 0.12 #x seconds
var noCancel = false
var cancelOffset = 0 #would've liked this to function more like a buffer but oh well
var animations = ["5AAA startup", "5AAA active", "5AAA recovery"]
