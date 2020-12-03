extends Button

var selected


# Called when the node enters the scene tree for the first time.
func _ready():
	selected = false


func _on_pressed():
	selected = !selected
	if selected:
		if PlayerData.equipped.size() < 2:
			get_node("../../MenuSFX").play("select2")
			self.add_color_override("font_color", Color.red)
			self.add_color_override("font_color_hover", Color.red)
			PlayerData.weapons.append(self.name.to_lower())
			PlayerData.equipped.append(self.name.to_lower())
			if GameData.merchantPool.has(self.name.to_lower()):
				GameData.merchantPool.remove(GameData.merchantPool.find(self.name.to_lower()))
		else:
			get_node("../../MenuSFX").play("deny")
			selected = false
	else:
		self.add_color_override("font_color", Color.white)
		self.add_color_override("font_color_hover", Color.white)
		var index = PlayerData.weapons.find(self.name.to_lower())
		PlayerData.weapons.remove(index)
		index = PlayerData.equipped.find(self.name.to_lower())
		PlayerData.equipped.remove(index)
		if !GameData.merchantPool.has(self.name.to_lower()):
			GameData.merchantPool.append(self.name.to_lower())
	print(PlayerData.equipped)
#	print(GameData.merchantPool)
