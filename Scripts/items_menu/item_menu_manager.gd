extends Node

var cursorIndex = 0
var itemCount = 0
var items

# Called when the node enters the scene tree for the first time.
func _ready():
	itemCount = get_node("Items").get_child_count()
	items = get_node("Items").get_children()
	items[cursorIndex].toggleHover()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_released("ui_left"):
		items[cursorIndex].toggleHover()
		cursorIndex -= 1
		if cursorIndex < 0:
			cursorIndex = itemCount - 1
		items[cursorIndex].toggleHover()
	if Input.is_action_just_released("ui_right"):
		items[cursorIndex].toggleHover()
		cursorIndex += 1
		if cursorIndex >= itemCount:
			cursorIndex = 0
		items[cursorIndex].toggleHover()
	if Input.is_action_just_released("ui_accept"):
		items[cursorIndex].toggleSelected()
