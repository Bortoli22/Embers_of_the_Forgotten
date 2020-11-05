extends Camera2D
var hold
var player
var shaking
var force

func _ready():
	hold = 0
	shaking = false
	force = 1
	player = self.get_parent()
	GameData.camera_node = self

func _process(_delta):
	if hold:
		pass
	else:
		if Input.is_action_pressed("ui_down"):
			position.y = 200
		elif Input.is_action_pressed("ui_right"):
			if (position.x < 81):
				position.x += 1
		elif Input.is_action_pressed("ui_left"):
			if (position.x > -81):
				position.x -= 1
		else:
			position = Vector2(0,0)
	if (shaking):
		set_offset(Vector2(rand_range(-1.0,1.0) * force, rand_range(-1.0,1.0) * force))
	

func shift(x,y):
	hold = 1
	position = Vector2(x,y)
	pass

func center(_speed):
	hold = 0
	pass
 

func shake(strength, duration):
	if (!shaking):
		shaking = true
		force = strength
		yield(get_tree().create_timer(duration), "timeout")
		shaking = false
