extends TileMap


# Grid Variables
var grid_size_x = 85
var grid_size_y = 25

# Verticle Slice Variables
var heightBase = 6
var heightMin = 4
var heightMax = 12
var height = 6
var heightAdjust = 0

var basePointBase = 12
var basePointMin = 3
var basePointMax = 40
var basePoint = 12
var basePointAdjust = 0

var VSlice1
var VSlice2
var VSlice3

var Tiles = {
	"C": 0,			#Center Tile
	"C_TL": 12,		#Ceiling Top Left
	"C_TR": 11,		#Ceiling Top Right
	"C_BL": 6,		#Ceiling Bottom Left
	"C_BR": 4,		#Ceiling Bottom Right
	"C_M": 5,		#Ceiling Middle
	"G_BL": 10,		#Ground Bottom Left
	"G_BR": 9,		#Ground Bottom Right
	"G_TL": 8,		#Ground Top Left
	"G_TR": 2,		#Ground Top Right
	"G_M": 1,		#Ground Middle
	"S_R": 3,		#Side Right
	"S_L": 7 		#Side Left
}

# Generate and evaluate the appropriate amount of Vertical Slices
func _ready():
	_V_setup()
	for xInt in range(0, grid_size_x):
		_v_slice_generate()
		_v_slice_evaluate(xInt)

# Initialize with the first three Vertical Slices
func _V_setup():
	_v_slice_generate()
	_v_slice_generate()
	_v_slice_generate()

# Obtain the data for a new Vertical Slice
func _v_slice_generate():
	VSlice1 = VSlice2
	VSlice2 = VSlice3
	_set_random_vars()

func _v_slice_evaluate_test(xInt): 
	for val in range(0, height):
		set_cell(xInt, basePoint + val, 6)

# Obtain tile data for VSlice2
func _v_slice_evaluate(xInt): 	
	var parseTemp
	var parseGoal
	
	# top tiles
	if (VSlice2.x + VSlice2.y) > (VSlice1.x + VSlice1.y):
		set_cell(xInt, basePointBase - VSlice2.y - VSlice2.x, Tiles.C_TL)
		parseGoal = basePointBase - VSlice1.y - VSlice1.x
		parseTemp = basePointBase - VSlice2.y - VSlice2.x + 1
		while parseTemp <= parseGoal:
			if parseTemp == parseGoal:
				set_cell(xInt, parseTemp, Tiles.C_BR)
			else:
				set_cell(xInt, parseTemp, Tiles.S_R)
			parseTemp += 1
	elif (VSlice2.x + VSlice2.y) > (VSlice3.x + VSlice3.y):
		set_cell(xInt, basePointBase - VSlice2.y - VSlice2.x, Tiles.C_TR)
		parseGoal = basePointBase - VSlice3.y - VSlice3.x
		parseTemp = basePointBase - VSlice2.y - VSlice2.x + 1
		while parseTemp <= parseGoal:
			if parseTemp == parseGoal:
				set_cell(xInt, parseTemp, Tiles.C_BL)
			else:
				set_cell(xInt, parseTemp, Tiles.S_L)
			parseTemp += 1
	else:
		set_cell(xInt, basePointBase - VSlice2.y - VSlice2.x, Tiles.C_M)
	
	# bottom tile
	if VSlice2.x < VSlice3.x:
		set_cell(xInt, basePointBase - VSlice2.x, Tiles.G_BR)
		parseGoal = basePointBase - VSlice3.x
		parseTemp = basePointBase - VSlice2.x - 1
		while parseTemp >= parseGoal:
			if parseTemp == parseGoal:
				set_cell(xInt, parseTemp, Tiles.G_TL)
			else:
				set_cell(xInt, parseTemp, Tiles.S_R)
			parseTemp -= 1
	elif VSlice2.x < VSlice1.x:
		set_cell(xInt, basePointBase - VSlice2.x, Tiles.G_BL)
		parseGoal = basePointBase - VSlice1.x
		parseTemp = basePointBase - VSlice2.x - 1
		while parseTemp >= parseGoal:
			if parseTemp == parseGoal:
				set_cell(xInt, parseTemp, Tiles.G_TR)
			else:
				set_cell(xInt, parseTemp, Tiles.S_L)
			parseTemp -= 1
	else:
		set_cell(xInt, basePointBase - VSlice2.x, Tiles.G_M)
	
	# middle tiles
	#set_cell(xInt, basePoint - yIntTop, 6)

# Compute random vals to determine VSlice behavior
func _set_random_vars():
	# get new height
	var x = randi() % 5
	# random var leading to a smaller height
	if x == 0 && height > heightMin && heightAdjust != 1 && basePointAdjust == 0:
		height -= 1
		heightAdjust = -1
	# random var leading to a larger height
	elif x == 1 && height < heightMax && heightAdjust != -1 && basePointAdjust == 0:
		height += 1
		heightAdjust = 1
	elif x > 1:
		heightAdjust = 0
	
	# get new midpoint
	x = randi() % 5
	# random var leading to a lower midpoint
	if x == 0 && basePoint > basePointMin && basePointAdjust != 1:
		basePoint -= 1
		basePointAdjust = -1
	# random var leading to a higher midpoint
	if x == 1 && basePoint < basePointMax && basePointAdjust != -1:
		basePoint += 1
		basePointAdjust = 1
	elif x > 1:
		basePointAdjust = 0
	
	# commit data to evaluatedSlice
	VSlice3 = Vector2(basePointBase - basePoint, height)
