extends Label


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var show = false
var format_string = "Wave: %s"
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func showLabel(waveNumber):
	
	text = format_string % waveNumber
	visible = true
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	if show :
		
