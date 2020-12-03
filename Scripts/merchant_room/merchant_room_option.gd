extends VBoxContainer


# Declare member variables here. Examples:
var hasSelection = false
var sID = -1
var options = []
var unlockables = []
onready var errorLog = get_node("../Submit/Error_Log")

# Called when the node enters the scene tree for the first time.
func _ready():
	#print("Loaded Merchant Menu. Items:")
	#print(GameData.merchantPool)
	
	get_node("PlayerMoney").text += str(PlayerData.currency)
	
	_get_valid_options()
	
	options.append({"id": 0, "NodeVal": get_node("Option1"), "isSelected": false})
	options.append({"id": 1, "NodeVal": get_node("Option2"), "isSelected": false})
	options.append({"id": 2, "NodeVal": get_node("Option3"), "isSelected": false})
	
	for val in options:
		var tText = unlockables[val.id].to_upper() + " : $"
		tText += str(GameData.merchantPrices[unlockables[val.id]])
		val.NodeVal.get_node("Label").text = tText
		val.NodeVal.get_node("Label").set("custom_colors/font_color", Color("#FFFFFF"))
		val.NodeVal.connect("pressed", self, "_selectionUpdate", [val.id])
	

func _selectionUpdate(id):
	if options[id].isSelected == true:
		hasSelection = false
		sID = -1
	else:
		hasSelection = true
		sID = id
	
	for val in options:
		val.isSelected = false
		val.NodeVal.get_node("Label").set("custom_colors/font_color", Color("#FFFFFF"))
	
	if hasSelection:
		options[id].isSelected = true
		options[id].NodeVal.get_node("Label").set("custom_colors/font_color", Color("#8b2a2a"))

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
	#if !hasSelection:
	#	errorLog.text = "CHOOSE AN UNLOCK FIRST!"
	#	return
	if sID != -1:
		if GameData.merchantPrices[unlockables[sID]] > PlayerData.currency:
			errorLog.text = "INSUFFICIENT FUNDS"
			return
		PlayerData.currency -= GameData.merchantPrices[unlockables[sID]]
	
	#add unchosen upgrades back into mix
	for val in options:
		if val.isSelected == false:
			if !(name == "---"):
				GameData.merchantPool.append(unlockables[val.id])
		else:
			var name = unlockables[val.id]
			if !(name == "---"):
				if name == "sword" || name == "spear" || name == "scythe" || name == "fireball" || name == "firewave":
					PlayerData.weapons.append(name)
				else:
					PlayerData.abilities.append(name)
	
	GameData.current_level += 1
	get_tree().change_scene("res://Scenes/Stage.tscn")
