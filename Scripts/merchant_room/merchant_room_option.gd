extends VBoxContainer


# Declare member variables here. Examples:
var isSelected = false
var options = []

# Called when the node enters the scene tree for the first time.
func _ready():
	_get_valid_options()
	
	options.append({"id": 0, "NodeVal": get_node("Option1"), "isSelected": false})
	options.append({"id": 1, "NodeVal": get_node("Option2"), "isSelected": false})
	options.append({"id": 2, "NodeVal": get_node("Option3"), "isSelected": false})
	
	for val in options:
		val.NodeVal.set("custom_colors/font_color", Color("#000000"))
		val.NodeVal.connect("pressed", self, "_selectionUpdate", [val.id])
	

func _selectionUpdate(id):
	print("entered with" + str(id))
	for val in options:
		val.isSelected = false
		val.NodeVal.set("custom_colors/font_color", Color("#000000"))
	
	options[id].isSelected = true
	options[id].NodeVal.set("custom_colors/font_color", Color("#FFFFFF"))

func _get_valid_options():
	var totalPoolSize = GameData.abilityMerchantPool.size() + GameData.weaponMerchantPool.size()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
