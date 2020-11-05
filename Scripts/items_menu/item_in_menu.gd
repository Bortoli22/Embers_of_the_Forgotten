extends Node

var hovered = false
var selected = false
var selectable = true
var texture_selected = load("res://Assets/items_menu/Border_Selected.png")
var texture_unselected = load("res://Assets/items_menu/Border_Unselected.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	if !PlayerData.weapons.has(self.name.to_lower()):
		selectable = false
		if has_node("ItemSprite"):
			get_node("ItemSprite").hide()
	if selected && selectable:
		get_node("Border").texture = texture_selected
	else:
		get_node("Border").texture = texture_unselected
	pass # Replace with function body.

func toggleHover():
	hovered = !hovered
	if hovered:
		get_node("Cursor").show()
	else:
		get_node("Cursor").hide()
	if get_node_or_null("ItemSprite") == null:
		return
	if hovered:
		get_node("ItemSprite").play()
	else:
		get_node("ItemSprite").stop()
		get_node("ItemSprite").frame = 0

func toggleSelected():
	if get_node_or_null("ItemSprite") == null:
		return
	if !PlayerData.weapons.has(self.name.to_lower()):
		return
	selected = !selected
	if selected:
		get_node("Border").texture = texture_selected
	else:
		get_node("Border").texture = texture_unselected

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
 pass
