extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var abilties = ["double jump", "dash", "triple jump"]


# Called when the node enters the scene tree for the first time.
func _ready():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var num = rng.randi_range(0,2)
	print(num)
	if num == 0 && abilties[num] != "":
		$"Movement Abilities/Double Jump".show()
		$"Movement Abilities/Dash".hide()
		$"Movement Abilities/Triple Jump".hide()
		abilties[num] != ""
	elif num == 1 && abilties[num] != "":
		$"Movement Abilities/Double Jump".hide()
		$"Movement Abilities/Dash".show()
		$"Movement Abilities/Triple Jump".hide()
		abilties[num] != ""
	elif num == 2 && abilties[num] != "":
		$"Movement Abilities/Double Jump".hide()
		$"Movement Abilities/Dash".hide()
		$"Movement Abilities/Triple Jump".show()
		abilties[num] != ""
	else:
		pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
