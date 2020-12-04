extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var hovered = false
var selected = false
var selectable = true
var texture_selected = load("res://Assets/items_menu/Border_Selected.png")
var texture_unselected = load("res://Assets/items_menu/Border_Unselected.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	if !PlayerData.skin == self.name :
		get_node("Border").texture = texture_selected
		if has_node("ItemSprite"):
			get_node("ItemSprite").hide()
		else:
			get_node("Border").texture = texture_unselected
	
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
 # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
