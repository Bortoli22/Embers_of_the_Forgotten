extends Node2D
var projectile = preload("res://Scenes/projectile.tscn")
var lastprojectile
var wepOrientation
var chargeable = false
var damage = 800
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	wepOrientation = 1
	pass # Replace with function body.


func attack(orientation):
	if (!is_instance_valid(lastprojectile)):
		orient(orientation)
		var p = projectile.instance() #The actual projectile object in the scene.
		p.set_damage(damage)
		p.transform = PlayerData.playerNode.get_transform()
		p.orientation = wepOrientation
		get_tree().get_root().add_child(p)
		lastprojectile = p
		$laser_sniper.visible = true
		yield(get_tree().create_timer(1.5), "timeout")
		$laser_sniper.visible = false
		PlayerData.wpnactionable = true

func orient(orientation):
	var flip 
	if (orientation):
		flip = wepOrientation*1
	else:
		flip = wepOrientation*-1
	if (flip != 1):
		transform *= Transform2D.FLIP_X
		#$Visual.set_flip_h(!orientation)
		wepOrientation *= -1
