extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_released("pause"):
		if GameData.paused:
			hide()
			GameData.paused = false
		else:
			GameData.paused = true
			show()
