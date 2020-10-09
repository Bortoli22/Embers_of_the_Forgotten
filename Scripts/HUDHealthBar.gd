extends ColorRect
var maxX = 420
var y
var ratio:float

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	y = self.get_rect().size.y
	pass # Replace with function body.

func init(initRatio):
	ratio = initRatio

func change(newratio:float):
	var chunk = load("res://Scenes/HBChunk.tscn")
	var chunkinstance = chunk.instance()
	var chunksize = Vector2(abs(newratio - ratio)*maxX, y)
	var chunkpos
	if (newratio < ratio):
		resize(newratio)
		chunkpos = (self.get_rect().size.x*2 + chunksize.x + 40) / 2
		chunkinstance.init(chunkpos, chunksize)
		add_child_below_node(self, chunkinstance)
	else:
		chunkpos = self.get_rect().size.x
		chunkinstance.init(chunkpos, chunksize)
		resize(newratio)
	ratio = newratio

func resize(newratio):
	self.set_size(Vector2(maxX*newratio,y))
	pass
