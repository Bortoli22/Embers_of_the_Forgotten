extends KinematicBody2D

var Player = PlayerData.playerNode

var vel = Vector2(0, 0)

var grav = 1800
var max_grav = 3000

var react_time = 400
var dir = 0
var next_dir = 0
var next_dir_time = 0

var next_jump_time = -1

var target_player_dist = 0

var eye_reach = 300
var vision = 600
#enable getting hit 


#Animation Finite State Machine
onready var animFSM = get_node("AnimationTree").get("parameters/playback")

#Attack Raycast
onready var ray = get_node("RayCast2D")

#Attack Reach for knowing when to actually try to attack
var attack_reach = 190
var attack_damage = 3

#Enemy Health
var health = 150

func _ready():
	animFSM.travel("Idle_L")
	set_process(true)

func set_dir(target_dir):
	if next_dir != target_dir:
		next_dir = target_dir
		next_dir_time = OS.get_ticks_msec() + react_time

func _process(delta):
	#setting correct x coordinate
	if Player.position.x < position.x - target_player_dist:
		if (animFSM.get_current_node() != "Idle_L"):
			animFSM.travel("Idle_L")
		set_dir(-1)
		ray.cast_to = Vector2(-190, 0)
	elif Player.position.x > position.x + target_player_dist :
		if (animFSM.get_current_node() != "Idle_R"):
			animFSM.travel("Idle_R")
		set_dir(1)
		ray.cast_to = Vector2(190, 0)
	else:
		set_dir(0)

	if OS.get_ticks_msec() > next_dir_time:
		dir = next_dir

	if OS.get_ticks_msec() > next_jump_time and next_jump_time != -1 and is_on_floor():
		if Player.position.y < position.y - 64:
			vel.y = -800
		next_jump_time = -1

	#conditioned so they don't come from across the map
	if abs(Player.position.x - position.x) < eye_reach:
		vel.x = dir * 300
	else:
		vel.x = 0
		vel.y = 0

#setting correct y coordinate 
	if Player.position.y < position.y - 64 and(next_jump_time == -1):
		next_jump_time = OS.get_ticks_msec() + react_time

	vel.y += grav * delta;
	if vel.y > max_grav:
		vel.y = max_grav

	if is_on_floor() and vel.y > 0:
		vel.y = 0
	#print("supposed to move")
	
	#check if should attack
	if abs(Player.position.x - position.x) < attack_reach:
		if dir > 0:
			animFSM.travel("Attack_R")
		elif dir < 0:
			animFSM.travel("Attack_L")
	
	#check if hitting
	if animFSM.get_current_node() != "Attack_L" or animFSM.get_current_node() == "Attack_R":
		var hits = ray.get_collider()
		if hits != null:
			if hits.name.find("Player") > -1:
				print("hit 3")
				healthChange(attack_damage * -1)
	
	vel = move_and_slide(vel, Vector2(0, -1))
	

func healthChange(amount):
	PlayerData.playerHealth += amount
	if PlayerData.playerHealth < 0:
		PlayerData.playerHealth = 0
	get_node("../../../HUD/HUD").change_health(PlayerData.playerHealth, float(PlayerData.playerHealth)/float(PlayerData.playerHealthMax))

func damageHandler(_damageValue, _orientation, _force):
		health -= 50 #standin
		print("got hit 3!")
		if (health <= 0):
			queue_free()

func _on_Get_Damage_area_exited(area):
	damageHandler(null, null, null)
