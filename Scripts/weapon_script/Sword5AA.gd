extends Area2D
var damageValue = 90
var force = Vector2(50, -100)
var staggerWindow = 0.2 #x seconds
var noCancel = false
var cancelOffset = 0
var animations = ["5AA startup", "5AA active", "5AA recovery"]
