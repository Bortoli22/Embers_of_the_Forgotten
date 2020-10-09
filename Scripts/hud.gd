extends Control
var main

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	main = get_tree().get_root().get_node("Main")
	var initHealth = main.get_node("Player").playerHealth
	var initHealthMax = main.get_node("Player").playerHealthMax
	get_node("HealthBar/HealthEmpty").color = Color8(3, 72, 9, 255)
	print(get_node("HealthBar/HealthEmpty").color)
	get_node("HealthBar/HealthGreen").init(float(initHealth)/float(initHealthMax))
	get_node("HealthBar/HealthText").text = str(initHealth) + "/" + str(initHealthMax)
	get_node("Money").text = str(main.get_node("Player").currency)
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.


func change_health(newHealth, ratio:float):
	get_node("HealthBar/HealthGreen").change(ratio)
	get_node("HealthBar/HealthText").text = str(newHealth) + "/" + str(main.get_node("Player").playerHealthMax)
	if (newHealth == 0):
		died()

func change_money(newMoney):
	get_node("Money").text = str(newMoney)

func died():
	get_node("HealthBar/HealthEmpty").color = Color(0,0,0,255)
	pass
