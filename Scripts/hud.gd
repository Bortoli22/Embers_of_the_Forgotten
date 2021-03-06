extends Control
#var main


# Called when the node enters the scene tree for the first time.
func _ready():
	#main = get_tree().get_root().get_node("Main")
	var initHealth = PlayerData.playerHealth
	var initHealthMax = PlayerData.playerHealthMax
	get_node("HealthBar/HealthEmpty").color = Color8(3, 72, 9, 255)
	get_node("HealthBar/HealthGreen").init(float(initHealth)/float(initHealthMax))
	get_node("HealthBar/HealthText").text = str(initHealth) + "/" + str(initHealthMax)
	get_node("Money").text = "Money: $" + str(PlayerData.currency)
	pass

#updating HUD values
func change_health(newHealth, ratio:float):
	get_node("HealthBar/HealthGreen").change(ratio)
	get_node("HealthBar/HealthText").text = str(newHealth) + "/" + str(PlayerData.playerHealthMax)
	if (newHealth == 0):
		died()

func change_money(newMoney):
	get_node("Money").text = "Money: $" + str(newMoney)
	if (newMoney > 0):
		$sfxcoin.play()

#func flash_notice(num):
	#get_node("Notice")

func died():
	get_node("HealthBar/HealthEmpty").color = Color(0,0,0,255)
	pass
