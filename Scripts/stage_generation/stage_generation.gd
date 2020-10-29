extends TileMap


# Grid Variables
var grid_size_x = 100
var grid_size_y = 25

# Verticle Slice Variables
var halfHeightBase = 3
var halfHeightMin = 2
var halfHeightMax = 4
var halfHeight = 3
var halfHeightAdjust = 0

var midpointYBase = 12
var midpointYMin = 3
var midpointYMax = 20
var midpointY = 12
var midpointYAdjust = 0

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
		_v_slice_evaluate_test(xInt)

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
	for val in range(0, 2*halfHeight):
		set_cell(xInt, midpointY - halfHeight + val, 6)

# Obtain tile data for VSlice2
func _v_slice_evaluate(xInt): 
	var yIntTop = 1
	var yIntBottom = VSlice2.y
	
	# top tile
	if VSlice2.x < VSlice1.x && VSlice2.x > VSlice3.x:
		set_cell(xInt, midpointY - halfHeight, Tiles.C_TL)
	elif VSlice2.x > VSlice1.x && VSlice2.x < VSlice3.x:
		set_cell(xInt, midpointY - halfHeight, Tiles.C_TR)
	elif VSlice2.x == VSlice1.x && VSlice2.x == VSlice3.x:
		set_cell(xInt, midpointY - halfHeight, Tiles.C_M)
	
	# bottom tile
	if (VSlice2.x + VSlice2.y) > (VSlice1.x + VSlice1.y):
		set_cell(xInt, midpointY - halfHeight + yIntBottom, Tiles.G_BR)
		yIntBottom -= 1
	elif (VSlice2.x + VSlice2.y) > (VSlice3.x + VSlice3.y):
		set_cell(xInt, midpointY - halfHeight + yIntBottom, Tiles.G_BL)
		yIntBottom -= 1
	elif (VSlice2.x + VSlice2.y) == (VSlice1.x + VSlice1.y) && (VSlice2.x + VSlice2.y) == (VSlice3.x + VSlice3.y):
		set_cell(xInt, midpointY - halfHeight + yIntBottom, Tiles.G_M)
		yIntBottom -= 1
	
	# middle tiles
	while yIntTop < yIntBottom:
		set_cell(xInt, midpointY - halfHeight + yIntTop, 6)
		yIntTop += 1
	
	print(VSlice1, VSlice2, VSlice3)

# Compute random vals to determine VSlice behavior
func _set_random_vars():
	# get new halfHeight
	var x = randi() % 8
	# random var leading to a smaller halfheight
	if x == 0 && halfHeight > halfHeightMin && halfHeightAdjust != 1:
		halfHeight -= 1
		halfHeightAdjust = -1
	# random var leading to a larger halfheight
	elif x == 1 && halfHeight < halfHeightMax && halfHeightAdjust != -1:
		halfHeight += 1
		halfHeightAdjust = 1
	elif x > 1:
		halfHeightAdjust = 0
	
	# get new midpoint
	x = randi() % 8
	# random var leading to a lower midpoint
	if x == 0 && midpointY > midpointYMin && midpointYAdjust != 1 && halfHeightAdjust != 0:
		midpointY -= 1
		midpointYAdjust = -1
	# random var leading to a higher midpoint
	if x == 1 && midpointY < midpointYMax && midpointYAdjust != -1 && halfHeightAdjust != 0:
		midpointY += 1
		midpointYAdjust = 1
	elif x > 1:
		midpointYAdjust = 0
	
	# commit data to evaluatedSlice
	VSlice3 = Vector2(midpointYBase - midpointY - halfHeight, halfHeight * 2)
