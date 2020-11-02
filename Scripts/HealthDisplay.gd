extends TextureProgress


var bar_green = preload("res://data/sprite/barHorizontal_green.png")



# Called when the node enters the scene tree for the first time.
func _ready():
	$".".texture_progress = bar_green
	if get_parent() and get_parent().get("maxHealth"):
		$".".max_value = get_parent().maxHealth
		$".".value = get_parent().maxHealth
	
func _process(delta):
	pass

func update_healthbar(value):
	$".".texture_progress = bar_green
	$".".value = value
	#print($".".value)
