extends VBoxContainer

var can_change = false
var action = ""
var button_to_action_map = {
	"JUMP": "ui_up",
	"LEFT": "ui_left",
	"RIGHT": "ui_right",
	"CROUCH": "ui_down",
	"WALLGRAB": "wall_grab",
	"DODGE": "dodge",
	"PRIMARYATTACK": "pr_fire", 
	"ALTATTACK": "alt_fire"
}

func _ready():
	set_keys()

func _input(event):
	if event is InputEventKey:
		if can_change:
			InputMap.action_erase_events(action)
			InputMap.action_add_event(action, event)
			set_keys()
			can_change = false
	elif event is InputEventMouseButton:
		if can_change:
			InputMap.action_erase_events(action)
			InputMap.action_add_event(action, event)
			set_keys()
			can_change =false
			
func set_keys():
	for k in button_to_action_map.keys():
		var button = get_node("HBox" + k + "/Button")
		var input_event = InputMap.get_action_list(button_to_action_map[k])[0]
		if input_event is InputEventMouseButton:
			if input_event.button_index == BUTTON_LEFT:
				button.text = "LMB"
			elif input_event.button_index == BUTTON_RIGHT:
				button.text = "RMB"
		elif input_event is InputEventKey:
			button.text = input_event.as_text()
		else:
			button.text = "No key assigned"

func _on_jump_pressed():
	can_change = true
	action = "ui_up"

func _on_left_pressed():
	can_change = true
	action = "ui_left"

func _on_right_pressed():
	can_change = true
	action = "ui_right"

func _on_crouch_pressed():
	can_change = true
	action = "ui_down"

func _on_wallgrab_pressed():
	can_change = true
	action = "wall_grab"

func _on_dodge_pressed():
	can_change = true
	action = "dodge"

func _on_primaryattack_pressed():
	can_change = true
	action = "pr_fire"

func _on_altattack_pressed():
	can_change = true
	action = "alt_fire"
