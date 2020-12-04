extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var enemy1Scene = load("res://Scenes/Enemies/EnemyVariant1.tscn")
var enemy2Scene = load("res://Scenes/Enemies/EnemyVariant2.tscn")
var enemy3Scene = load("res://Scenes/Enemies/EnemyVariant3.tscn")
var enemy4Scene = load("res://Scenes/Enemies/EnemyVariant4.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	add_child() # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
