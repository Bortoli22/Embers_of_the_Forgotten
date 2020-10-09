extends Node2D
var healthValue = 400
var damageValue = 200
var orientation
var rng = RandomNumberGenerator.new()
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	orientation = 1
	pass # Replace with function body.

#func behaviorCore():
	#pass

#func behaviorPattern1():
	#pass
	
#func behaviorPattern2():
	#pass
	
#func behaviorPattern3():
	#pass

func damageHandler(damage, direction, force):
	healthValue -= damageValue
	knockback(direction, force)
	if healthValue <= 0: 
		died()

func knockback(direction, force):
	pass

func died():
	drops()
	queue_free()

func drops():
	generate("res://Scenes/Coin.tscn", 1, 5, 10, 75)
	generate("res://Scenes/pickup_health.tscn", 1, 2, 50, 75)
	
func generate(scene, lowerCount, upperCount, lowerValue, upperValue):
	rng.randomize()
	for i in range (rng.randi_range(lowerCount, upperCount)):
		var c = load(scene)
		var cinstance = c.instance()
		cinstance.init(rng.randi_range(lowerValue, upperValue), rng.randi_range(-100,100))
		cinstance.transform = self.get_transform()
		get_owner().add_child(cinstance)
	

func _on_hitbox_body_entered(body):
	if body.has_method("damageHandler"):
		body.damageHandler(damageValue, orientation, Vector2(800,-500))
