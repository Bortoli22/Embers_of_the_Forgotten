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

var eye_reach = 90
var vision = 600

func _ready():
	set_process(true)

func set_dir(target_dir):
	if next_dir != target_dir:
		next_dir = target_dir
		next_dir_time = OS.get_ticks_msec() + react_time

func _process(delta):
	#setting correct x coordinate
	if Player.position.x < position.x - target_player_dist:
		set_dir(-1)
	elif Player.position.x > position.x + target_player_dist :
		set_dir(1)
	else:
		set_dir(0)

	if OS.get_ticks_msec() > next_dir_time:
		dir = next_dir

	if OS.get_ticks_msec() > next_jump_time and next_jump_time != -1 and is_on_floor():
		if Player.position.y < position.y - 64:
			vel.y = -800
		next_jump_time = -1

	vel.x = dir * 500
#setting correct y coordinate 
	if Player.position.y < position.y - 64 and(next_jump_time == -1):
		next_jump_time = OS.get_ticks_msec() + react_time

	vel.y += grav * delta;
	if vel.y > max_grav:
		vel.y = max_grav

	if is_on_floor() and vel.y > 0:
		vel.y = 0
	print("supposed to move")
	vel = move_and_slide(vel, Vector2(0, -1))
