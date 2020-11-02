extends Node2D

func _process(delta):
	if Input.is_action_pressed("cam_up_test"):
			position.y -= 1
	if Input.is_action_pressed("cam_down_test"):
			position.x += 1
	if Input.is_action_pressed("cam_right_test"):
			position.x += 1
	if Input.is_action_pressed("cam_left_test"):
			position.x -= 1

