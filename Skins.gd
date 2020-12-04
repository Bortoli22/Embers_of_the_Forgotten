extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var playerNode

var cursorIndex 
var skinCount = 0
var skins
var open = false
# Called when the node enters the scene tree for the first time.
func _ready():
	#playerNode = get_node()
	self.hide()
	pause_mode = Node.PAUSE_MODE_PROCESS # Replace with function body.
	skinCount = get_node("Skins").get_child_count()
	skins = get_node("Skins").get_children()
	cursorIndex = PlayerData.availableSkins.find(PlayerData.skin)
	skins[cursorIndex].toggleHover()

func toggle_menu():
	if is_visible_in_tree():
			hide()
			get_tree().paused = false
			open = false

			#GameData.paused = false
	else:
		$MenuSFX.play("open")
		get_tree().paused = true
		open = true
		#GameData.paused = true

		show()
		
	
func _process(delta):
	if open:
		if Input.is_action_just_released("ui_left"):
			$MenuSFX.play("move")
			skins[cursorIndex].toggleHover()
			cursorIndex -= 1
			if cursorIndex < 0:
				cursorIndex = skinCount - 1
			skins[cursorIndex].toggleHover()
		if Input.is_action_just_released("ui_right"):
			$MenuSFX.play("move")
			skins[cursorIndex].toggleHover()
			cursorIndex += 1
			if cursorIndex >= skinCount:
				cursorIndex = 0
			skins[cursorIndex].toggleHover()
		if Input.is_action_just_released("ui_accept"):
			$MenuSFX.play("select2")
			PlayerData.skin = skins[cursorIndex].name
			if !skins[cursorIndex].selectable:
				return
			
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_CloseMenu_pressed():
	toggle_menu() # Replace with function body.
