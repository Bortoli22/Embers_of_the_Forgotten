extends Node2D
var wpnslot = -1
var action = ""

#moveset control
const FIRERATE = 0.3 #interval in seconds\
const MAX_PROJECTILES = 30
var projectile = preload("res://Scenes/projectile.tscn")
var projPool
var curProj = 0

#move control
var wepOrientation

#for charge moves
var chargeable = true
var charging = false
var negEdge = false

#node references
onready var sprite = $Visual
#onready var animation = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	sprite.frame = 0
	wepOrientation = 1
	PlayerData.wpnactionable = true
	projPool = generateProjectiles()

# will need to examine multithreading issues / lock better eventually
func attack(orientation):
	if (!PlayerData.playerNode.jump_count > 0 && !PlayerData.playerNode.jumping):
		PlayerData.playerNode.capSpeed(200)
	orient(orientation)
	project()
	yield(get_tree().create_timer(FIRERATE), "timeout")
	PlayerData.playerNode.capSpeed(600)
	PlayerData.wpnactionable = true

func generateProjectiles():
	var tempPool = []
	for y in range(MAX_PROJECTILES):
		var p = projectile.instance()
		tempPool.append(p)
	return tempPool
	

func project():
		if (curProj >= MAX_PROJECTILES):
			curProj = 0
		var p = projPool[curProj]
		curProj += 1
		p.transform = PlayerData.playerNode.get_transform()
		p.orientation = wepOrientation
		get_tree().get_root().add_child(p)
	

func orient(orientation):
	var flip 
	if (orientation):
		flip = wepOrientation*1
	else:
		flip = wepOrientation*-1
	if (flip != 1):
		transform *= Transform2D.FLIP_X
		wepOrientation *= -1

func get_action():
	if (action == ""):
		if (wpnslot > -1):
			if (wpnslot == 1):
				action = "pr_fire"
			elif (wpnslot == 2):
				action = "alt_fire"
	return action
