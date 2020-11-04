extends MenuButton


# Declare member variables here.
var popup


# Called when the node enters the scene tree for the first time.
func _ready():
	popup = get_popup()
	popup.add_item("Melee Items")
	popup.add_item("Range Items")
	popup.add_item("Weapon Unlocks")
	popup.connect("id_pressed", popup, "_on_id_pressed")



# Called on popup update.
func _on_id_pressed(ID):
	print("item pressed")
	match popup.get_item_text(ID):
		"Melee Items":
			print("Melee Items")
			$"../MeleeItems".visible = true
			$"../RangeItems".visible = false
			$"../Unlocks".visible = false
		"Range Items":
			print("Range Items")
			$"../MeleeItems".visible = false
			$"../RangeItems".visible = true
			$"../Unlocks".visible = false
		"Weapon Unlocks":
			print("Weapon Unlocks")
			$"../MeleeItems".visible = false
			$"../RangeItems".visible = false
			$"../Unlocks".visible = true
