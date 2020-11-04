extends Button

var selected


# Called when the node enters the scene tree for the first time.
func _ready():
	selected = false


func _on_pressed():
	selected = !selected
	if selected:
		self.add_color_override("font_color", Color.red)
		self.add_color_override("font_color_hover", Color.red)
		PlayerData.weapons.append(self.name.to_lower())
		if GameData.merchantPool.has(self.name.to_lower()):
			GameData.merchantPool.remove(GameData.merchantPool.find(self.name.to_lower()))
	else:
		self.add_color_override("font_color", Color.white)
		self.add_color_override("font_color_hover", Color.white)
		var index = PlayerData.weapons.find(self.name.to_lower())
		PlayerData.weapons.remove(index)
		if !GameData.merchantPool.has(self.name.to_lower()):
			GameData.merchantPool.append(self.name.to_lower())

	print(GameData.merchantPool)
