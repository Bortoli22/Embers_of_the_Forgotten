extends VBoxContainer


# Declare member variables here. Examples:
var hasSelection = false
var options = []
var unlockables = []
onready var errorLog = get_node("../Submit/Error_Log")

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Loaded Merchant Menu. Items:")
	print(GameData.merchantPool)
	
	_get_valid_options()
	
	options.append({"id": 0, "NodeVal": get_node("Option1"), "isSelected": false})
	options.append({"id": 1, "NodeVal": get_node("Option2"), "isSelected": false})
	options.append({"id": 2, "NodeVal": get_node("Option3"), "isSelected": false})
	
	for val in options:
		val.NodeVal.text = unlockables[val.id].to_upper()
		val.NodeVal.set("custom_colors/font_color", Color("#000000"))
		val.NodeVal.connect("pressed", self, "_selectionUpdate", [val.id])
	

func _selectionUpdate(id):
	hasSelection = true
	for val in options:
		val.isSelected = false
		val.NodeVal.set("custom_colors/font_color", Color("#000000"))
	
	options[id].isSelected = true
	options[id].NodeVal.set("custom_colors/font_color", Color("#FFFFFF"))

func _get_valid_options():
	var totalPoolSize = GameData.merchantPool.size()
	for _x in range(3):
		if totalPoolSize == 1:
			unlockables.append(GameData.merchantPool[0])
			GameData.merchantPool.remove(0)
			totalPoolSize = totalPoolSize - 1
		elif totalPoolSize > 1:
			var itemIndex = randi() % totalPoolSize - 1
			unlockables.append(GameData.merchantPool[itemIndex])
			GameData.merchantPool.remove(itemIndex)
			totalPoolSize = totalPoolSize - 1
		else:
			unlockables.append("---")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Submit_pressed():
	if !hasSelection:
		errorLog.text = "CHOOSE AN UNLOCK FIRST!"
		return
	#add unchosen upgrades back into mix
	for val in options:
		if val.isSelected == false:
			if !(name == "---"):
				GameData.merchantPool.append(unlockables[val.id])
		else:
			var name = unlockables[val.id]
			if !(name == "---"):
				if name == "sword" || name == "spear" || name == "scythe":
					PlayerData.weapons.append(name)
				else:
					PlayerData.abilities.append(name)
	
	GameData.current_level += 1
	get_tree().change_scene("res://Scenes/Stage.tscn")
