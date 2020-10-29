extends Node2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("cam_down_test"):
		position.y += 10
	if Input.is_action_pressed("cam_up_test"):
		position.y -= 10
	if Input.is_action_pressed("cam_left_test"):
		position.x -= 10
	if Input.is_action_pressed("cam_right_test"):
		position.x += 10
