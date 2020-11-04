extends Camera2D
var hold
var player

func _ready():
	hold = 0
	player = self.get_parent()

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

func shift(x,y):
	hold = 1
	position = Vector2(x,y)
	pass

func center(_speed):
	hold = 0
	pass
 

#could define behavior for left/right extremes of map


func shake(_force, _duration):
	#could determine a set of directions, 
	#randomize it on call and then execute movements based on force + slight randomization
	#repeat for (duration) cycles
	pass
