extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	if PlayerData.rangedUnlocks[2]:
		$".".texture = load("res://data/sprite/Unlocked.png")
	else:
		$".".texture = load("res://data/sprite/Locked.png")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
