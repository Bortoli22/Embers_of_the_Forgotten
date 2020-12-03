extends PopupMenu


# Declare member variables here.
#onready var popup = self.get_node("PopupMenu")

# Called when the node enters the scene tree for the first time.
func _ready():
	print()
	#self.popup()
	self.add_item("Melee Items")
	self.add_item("Range Items")
	self.add_item("Weapon Unlocks")
	self.connect("id_pressed", self, "_on_id_pressed")
	#print("AAA")


# Called on popup update.
func _on_id_pressed(ID):
	print("item pressed")
	match self.get_item_text(ID):
		"Melee Items":
			#print("Melee Items")
			$"../MeleeItems".visible = true
			$"../RangeItems".visible = false
			$"../Unlocks".visible = false
		"Range Items":
			#print("Range Items")
			$"../MeleeItems".visible = false
			$"../RangeItems".visible = true
			$"../Unlocks".visible = false
		"Weapon Unlocks":
			#print("Weapon Unlocks")
			$"../MeleeItems".visible = false
			$"../RangeItems".visible = false
			$"../Unlocks".visible = true
	self.popup()
