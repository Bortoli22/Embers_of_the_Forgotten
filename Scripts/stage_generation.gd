extends TileMap


# Declare member variables here. Examples:
var grid_size_x = 100
var grid_size_y = 50
# var b = "text"

#V-Slice Variables
var halfHeightMin = 4
var halfHeightMax

# Called when the node enters the scene tree for the first time.
func _ready():
	for x in range(0, grid_size_x):
		set_cell(x, x, randi() % 12)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
