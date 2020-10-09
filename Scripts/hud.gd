extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var initHealth = get_parent().get_node("Player").playerHealth
	var initHealthMax = get_parent().get_node("Player").playerHealthMax
	get_node("HealthBar").get_node("HealthGreen").init(float(initHealth)/float(initHealthMax))
	get_node("HealthBar").get_node("HealthText").text = str(initHealth) + "/" + str(initHealthMax)
	get_node("Money").text = str(get_parent().get_node("Player").currency)
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.


func change_health(newHealth, ratio:float):
	get_node("HealthBar").get_node("HealthGreen").change(ratio)
	get_node("HealthBar").get_node("HealthText").text = str(newHealth) + "/" + str(get_parent().get_node("Player").playerHealthMax)
	

func change_money(newMoney):
	get_node("Money").text = str(newMoney)

func died():
	pass
