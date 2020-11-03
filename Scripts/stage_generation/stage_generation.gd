extends TileMap


# Grid Variables
var grid_size_x = 200
var grid_size_y = 25

# Verticle Slice Variables
var heightBase = 6
var heightMin = 6
var heightMax = 12
var height = 8
var heightAdjust = 0
var heightAdjustCounter = 3

var basePointBase = 12
var basePointMin = 3
var basePointMax = 40
var basePoint = 12
var basePointAdjust = 0
var basePointAdjustCounter = 3

var VSlice1
var VSlice2
var VSlice3

var isRoom = false
var roomLength = 12
var roomLengthMin = 10
var roomLengthMax = 22

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
	#for a consistent, testable seed, comment the below line
	randomize()
	
	_V_setup()
	var iterator = 1
	while iterator < grid_size_x:
		_v_slice_generate()
		_v_slice_evaluate(iterator)
		# room logic
		if isRoom:
			isRoom = false
			VSlice1 = VSlice2
			VSlice2 = VSlice3
			VSlice3.y += 5
			_v_slice_evaluate(iterator + 1)
			VSlice1 = VSlice2
			VSlice2 = VSlice3
			_v_slice_evaluate(iterator + 1)
			VSlice1 = VSlice2
			for val in range(roomLength):
				_v_slice_evaluate(iterator + val + 2)
			#print("found room on iteration: " + str(iterator))
			iterator += roomLength + 1
		iterator += 1
	_V_finalize(iterator)

# Initialize with the first three Vertical Slices
func _V_setup():
	#get data of first three slices
	_v_slice_generate()
	VSlice1 = VSlice3
	VSlice2 = VSlice3

	#set left corner
	set_cell(0, basePointBase - VSlice1.x, Tiles.G_BL)
	for x in VSlice1.y - 1:
		set_cell(0, basePointBase - VSlice1.x - x - 1, Tiles.S_R)
	set_cell(0, basePointBase - VSlice1.x - VSlice1.y, Tiles.C_TL)

# Obtain the data for a new Vertical Slice
func _v_slice_generate():
	VSlice1 = VSlice2
	VSlice2 = VSlice3
	_set_random_vars()

func _v_slice_evaluate_test(iterator): 
	for val in range(0, height):
		set_cell(iterator, basePoint + val, 6)

# Obtain tile data for VSlice2
func _v_slice_evaluate(iterator):
	var parseTemp
	var parseGoal
	
	# top tiles
	if (VSlice2.x + VSlice2.y) > (VSlice1.x + VSlice1.y):
		set_cell(iterator, basePointBase - VSlice2.y - VSlice2.x, Tiles.C_TL)
		parseGoal = basePointBase - VSlice1.y - VSlice1.x
		parseTemp = basePointBase - VSlice2.y - VSlice2.x + 1
		while parseTemp <= parseGoal:
			if parseTemp == parseGoal:
				set_cell(iterator, parseTemp, Tiles.C_BR)
			else:
				set_cell(iterator, parseTemp, Tiles.S_R)
			parseTemp += 1
	elif (VSlice2.x + VSlice2.y) > (VSlice3.x + VSlice3.y):
		set_cell(iterator, basePointBase - VSlice2.y - VSlice2.x, Tiles.C_TR)
		parseGoal = basePointBase - VSlice3.y - VSlice3.x
		parseTemp = basePointBase - VSlice2.y - VSlice2.x + 1
		while parseTemp <= parseGoal:
			if parseTemp == parseGoal:
				set_cell(iterator, parseTemp, Tiles.C_BL)
			else:
				set_cell(iterator, parseTemp, Tiles.S_L)
			parseTemp += 1
	else:
		set_cell(iterator, basePointBase - VSlice2.y - VSlice2.x, Tiles.C_M)
	
	# bottom tile
	if VSlice2.x < VSlice3.x:
		set_cell(iterator, basePointBase - VSlice2.x, Tiles.G_BR)
		parseGoal = basePointBase - VSlice3.x
		parseTemp = basePointBase - VSlice2.x - 1
		while parseTemp >= parseGoal:
			if parseTemp == parseGoal:
				set_cell(iterator, parseTemp, Tiles.G_TL)
			else:
				set_cell(iterator, parseTemp, Tiles.S_R)
			parseTemp -= 1
	elif VSlice2.x < VSlice1.x:
		set_cell(iterator, basePointBase - VSlice2.x, Tiles.G_BL)
		parseGoal = basePointBase - VSlice1.x
		parseTemp = basePointBase - VSlice2.x - 1
		while parseTemp >= parseGoal:
			if parseTemp == parseGoal:
				set_cell(iterator, parseTemp, Tiles.G_TR)
			else:
				set_cell(iterator, parseTemp, Tiles.S_L)
			parseTemp -= 1
	else:
		set_cell(iterator, basePointBase - VSlice2.x, Tiles.G_M)
	
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
		heightAdjustCounter = 3
	# random var leading to a larger height
	elif x == 1 && height < heightMax && heightAdjust != -1 && basePointAdjust == 0:
		height += 1
		heightAdjust = 1
		heightAdjustCounter = 3
	else:
		heightAdjustCounter -= 1
		if heightAdjustCounter <= 0:
			heightAdjust = 0
	
	# get new midpoint
	x = randi() % 5
	# random var leading to a lower midpoint
	if x == 0 && basePoint > basePointMin && basePointAdjust != 1 && heightAdjust == 0:
		basePoint -= 1
		basePointAdjust = -1
		basePointAdjustCounter = 3
	# random var leading to a higher midpoint
	if x == 1 && basePoint < basePointMax && basePointAdjust != -1 && heightAdjust == 0:
		basePoint += 1
		basePointAdjust = 1
		basePointAdjustCounter = 3
	else:
		basePointAdjustCounter -= 1
		if basePointAdjustCounter <= 0:
			basePointAdjust = 0
	
	# random var leading to a room being generated
	x = randi() % 100
	if x == 1:
		isRoom = true
		x = randi() % (roomLengthMax - roomLengthMin)
		roomLength = x + roomLengthMin
	
	# commit data to evaluatedSlice
	VSlice3 = Vector2(basePointBase - basePoint, height)

func _V_finalize(iterator):
	#get data of first three slices
	VSlice1 = VSlice2
	VSlice2 = VSlice3
	_v_slice_evaluate(iterator)
	

	#set left corner
	set_cell(iterator + 1, basePointBase - VSlice2.x, Tiles.G_BR)
	for x in VSlice1.y - 1:
		set_cell(iterator + 1, basePointBase - VSlice2.x - x - 1, Tiles.S_L)
	set_cell(iterator + 1, basePointBase - VSlice2.x - VSlice2.y, Tiles.C_TR)
