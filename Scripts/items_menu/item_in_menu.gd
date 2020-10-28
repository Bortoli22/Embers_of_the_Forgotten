extends Node

var hovered = false
var selected = false
var texture_selected = "res://Assets/items_menu/Border_Selected.png"
var texture_unselected = "res://Assets/items_menu/Border_Unselected.png"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func toggleHover():
	hovered = !hovered
	if hovered:
		get_node("ItemSprite").play()
	else:
		get_node("ItemSprite").stop()
		get_node("ItemSprite").frame = 0

func toggleSelected():
	selected = !selected
	if selected:
		get_node("Border").texture = texture_selected
	else:
		get_node("Border").texture = texture_unselected

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_released("ui_left"):
		toggleHover()
	if Input.is_action_just_released("ui_right"):
		toggleSelected()
