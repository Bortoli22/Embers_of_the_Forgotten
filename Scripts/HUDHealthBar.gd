extends ColorRect
var maxlength
var ratio:float

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func init(initRatio):
	ratio = initRatio

func change(newratio:float):
	var chunk = load("res://Scenes/HBChunk.tscn")
	var chunkinstance = chunk.instance()
	if (newratio < ratio):
		chunkinstance.init(0)
		add_child_below_node(self, chunkinstance)
	else:
		chunkinstance.init(1)
		ratio = newratio

func resize(newratio):
	pass
