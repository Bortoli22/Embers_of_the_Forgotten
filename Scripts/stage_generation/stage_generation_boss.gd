extends StaticBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	if GameData.current_level % 4 == 0:
		show()
		scale = Vector2(1,1)
	else:
		hide()
		scale = Vector2(0,0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
