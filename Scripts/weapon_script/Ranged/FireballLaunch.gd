extends Node2D
var wpnslot = -1
var action = ""

#moveset control
const STARTUP = 0.3 #interval in seconds\
const FIRERATE = 0.7 #interval in seconds\
const MAX_PROJECTILES = 30
var projectile = preload("res://Scenes/FireballProj.tscn")

#move control
var wepOrientation

#for charge moves
var chargeable = true
var charging = false
var negEdge = false

#node references
#onready var animation = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	wepOrientation = 1
	PlayerData.wpnactionable = true

# will need to examine multithreading issues / lock better eventually
func attack(orientation):
	if (!PlayerData.playerNode.jump_count > 0 && !PlayerData.playerNode.jumping):
		PlayerData.playerNode.capSpeed(200)
	orient(orientation)
	var p = projectile.instance()
	yield(get_tree().create_timer(STARTUP), "timeout")
	p.transform = PlayerData.playerNode.get_transform()
	p.transform.origin.x += 35*wepOrientation
	p.orientation = wepOrientation
	get_tree().get_root().add_child(p)
	$sfx.play(0)
	PlayerData.playerNode.capSpeed(600)
	yield(get_tree().create_timer(FIRERATE), "timeout")
	PlayerData.wpnactionable = true

#func generateProjectiles():
#	var tempPool = []
#	for y in range(MAX_PROJECTILES):
#		var p = projectile.instance()
#		tempPool.append(p)
#	return tempPool
	
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
