extends ColorRect
var maxlength
var ratio

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func change(newratio):
	var chunk = load("res://CHUNK.tscn")
	var chunkinstance = chunk.instance()
	if (newratio < ratio):
		chunkinstance.init(0)
		add_child_below_node(self, chunkinstance)
	else:
		chunkinstance.init(1)
		ratio = newratio

func resize(newratio):
	pass
