extends StaticBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var enemy0Scene = load("res://Scenes/Slime.tscn")
var enemy1Scene = load("res://Scenes/Enemies/EnemyVariant1.tscn")
var enemy2Scene = load("res://Scenes/Enemies/EnemyVariant2.tscn")
var enemy3Scene = load("res://Scenes/Enemies/EnemyVariant3.tscn")
var enemy4Scene = load("res://Scenes/Enemies/EnemyVariant4.tscn")

var initialEnemiesSpawned = false

var wavesSurvived = 0
var maxNumWaves

onready var waveLabel = get_node("WaveLabel")
# Called when the node enters the scene tree for the first time.
func _ready():
	if GameData.current_level as int % 4 == 0:
		GameData.roomEnemyCount = 0
		show()
		spawnInitialEnemies()
		GameData.bossRoomFinished = false
		maxNumWaves = GameData.current_level / 4
		scale = Vector2(1,1)
	else:
		hide()
		scale = Vector2(0,0)
		
	

func spawnInitialEnemies():
	
	GameData.roomEnemyCount += 2
	var enemy1 = enemy1Scene.instance()
	add_child(enemy1)
	
	var enemy2 = enemy2Scene.instance()
	add_child(enemy2)

	initialEnemiesSpawned = true
	waveLabel.showLabel(1)
	

func spawnNextWave():
	wavesSurvived += 1
	if wavesSurvived == 1 :
		add_child(enemy2Scene.instance())
		add_child(enemy3Scene.instance())
		GameData.roomEnemyCount += 2
	elif wavesSurvived == 2 :
		add_child(enemy3Scene.instance())
		add_child(enemy4Scene.instance())
		GameData.roomEnemyCount += 2
	elif wavesSurvived == 3 :
		add_child(enemy4Scene.instance())
		add_child(enemy4Scene.instance())
		GameData.roomEnemyCount += 2
	waveLabel.showLabel(wavesSurvived+1)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if initialEnemiesSpawned && GameData.roomEnemyCount == 0 :	
		if wavesSurvived < maxNumWaves :
			spawnNextWave()
		else :
			GameData.bossRoomFinished = true
			waveLabel.visible = false
	
