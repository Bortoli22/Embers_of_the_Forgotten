extends StaticBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var enemy0Scene = load("res://Scenes/Slime.tscn")
var enemy1Scene = load("res://Scenes/Enemies/EnemyVariant1.tscn")
var enemy2Scene = load("res://Scenes/Enemies/EnemyVariant2.tscn")
var enemy3Scene = load("res://Scenes/Enemies/EnemyVariant3.tscn")
var enemy4Scene = load("res://Scenes/Enemies/EnemyVariant4.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	if GameData.current_level as int % 4 == 0:
		show()
		scale = Vector2(1,1)
	else:
		hide()
		scale = Vector2(0,0)
	spawnEnemies()

func spawnEnemies():
	GameData.roomEnemyCount = 1
	var enemy = enemy0Scene.instance()
	add_child(enemy)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
