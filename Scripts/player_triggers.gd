extends Area2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#pass

func add_money(value):
	var Player = get_parent()
	PlayerData.currency += value
	
#	Player.currency += value
	#Player.main.get_node("CanvasLayer").get_node("HUD").change_money(PlayerData.currency)
	var add = get_node_or_null("../../HUD/HUD")
	
	if add != null:
		add.change_money(PlayerData.currency)
		print("added")
	else:
		print("nulll")
	#trigger sounds and stuff
