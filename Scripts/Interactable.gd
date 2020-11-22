extends RigidBody2D


# Declare member variables here.
var type = null
var destructHealth = 100
var indestructible = false
var rng = RandomNumberGenerator.new()
var coin = preload("res://Scenes/Coin.tscn")
var health = preload("res://Scenes/pickup_health.tscn")

# Possible sprites
onready var sprite = get_node("Sprite")


# Called when the node enters the scene tree for the first time.
func _ready():
	var determinant = randi() % 4
	match determinant:
		0:
			type = "eye"
			sprite.texture = load("res://Assets/interactables/interactables_0.png")
			indestructible = true
		1:
			type = "money"
			sprite.texture = load("res://Assets/interactables/interactables_1.png")
		2:
			type = "health"
			sprite.texture = load("res://Assets/interactables/interactables_2.png")
		3:
			type = "crate"
			sprite.texture = load("res://Assets/interactables/interactables_3.png")
	

func damageHandler():
	if !indestructible:
		destructHealth -= 20
		if (destructHealth <= 0):
			destroyInteractable()

func destroyInteractable():
	drops()
	queue_free()

func drops():
	if type == "crate":
		generateCoin(1, 5, 10, 75)
	if type == "health":
		generateHealth(1, 2, 50, 75)

func generateCoin(lowerCount, upperCount, lowerValue, upperValue):
	rng.randomize()
	for _i in range (rng.randi_range(lowerCount, upperCount)):
		var cinstance = coin.instance()
		cinstance.init(rng.randi_range(lowerValue, upperValue), rng.randi_range(-100,100))
		cinstance.transform = get_transform()
		add_child(cinstance)
	

func generateHealth(lowerCount, upperCount, lowerValue, upperValue):
	rng.randomize()
	for _i in range (rng.randi_range(lowerCount, upperCount)):
		var cinstance = health.instance()
		cinstance.init(rng.randi_range(lowerValue, upperValue), rng.randi_range(-100,100))
		cinstance.transform = get_transform()
		add_child(cinstance)

func _on_Break_area_exited(body):
	print("Exited")
	damageHandler()

func _on_Break_area_entered(body):
	print("Entered")
	damageHandler()
