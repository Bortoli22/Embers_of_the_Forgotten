extends Area2D

func add_money(value):
	var Player = get_parent()
	PlayerData.currency += value
	var add = get_node_or_null("../../HUD/HUD")
	if add != null:
		get_node("../SFX/coin").play()
		add.change_money(PlayerData.currency)
	#trigger sounds and stuff
