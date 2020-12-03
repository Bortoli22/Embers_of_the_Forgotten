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
onready var hitsound = [$tin1, $tin2, $tin3]


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
	

func damageHandler(_damageValue, _orientation, _force):
	if destructHealth > 0:
		var x = floor(rand_range(0,2.99))
		hitsound[x].play()
		if !indestructible:
			destructHealth -= 40
			if (destructHealth <= 0):
				hide()
				yield(get_tree().create_timer(0.18), "timeout")
				destroyInteractable()

func destroyInteractable():
	drops()
	queue_free()

func drops():
	if type == "crate":
		generateCoin(2, 5, 10, 75)
	if type == "money":
		generateCoin(5, 10, 10, 75)
	if type == "health":
		generateHealth(1, 2, 50, 75)

func generateCoin(lowerCount, upperCount, lowerValue, upperValue):
	rng.randomize()
	for _i in range (rng.randi_range(lowerCount, upperCount)):
		var cinstance = coin.instance()
		cinstance.init(rng.randi_range(lowerValue, upperValue), rng.randi_range(-100,100))
		cinstance.transform = get_transform()
		get_parent().add_child(cinstance)
	

func generateHealth(lowerCount, upperCount, lowerValue, upperValue):
	rng.randomize()
	for _i in range (rng.randi_range(lowerCount, upperCount)):
		var cinstance = health.instance()
		cinstance.init(rng.randi_range(lowerValue, upperValue), rng.randi_range(-100,100))
		cinstance.transform = get_transform()
		get_parent().add_child(cinstance)

func _on_Break_area_exited(body):
	#damageHandler(null, null, null)
	pass
