extends KinematicBody2D

var velocity = Vector2()
var movement = 400
var damageValue = 200
var orientation = 1
var force = Vector2(0,0) #no pushback
# Called when the node enters the scene tree for the first time.

func _physics_process(_delta):
	var _MASret = move_and_slide(velocity)
	#print(position.y)
	if position.x < -1000:
		queue_free()

func fire(orient, transf):
	orientation = orient
	velocity.x = movement*orient
	transform = transf
	PlayerData.playerNode.get_parent().add_child()

func _on_FireballProj_body_entered(body):
	if (body.has_method("damageHandler")):
		body.damageHandler(damageValue, orientation, force)
	get_parent().remove_child(self)
	
	pass # Replace with function body.
