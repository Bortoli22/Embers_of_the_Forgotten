extends KinematicBody2D

var velocity = Vector2()
var movement = 400
var damageValue = 200

# Called when the node enters the scene tree for the first time.
func _ready():
	velocity.x = 3*movement # Replace with function body.

func _physics_process(delta):
	move_and_slide(velocity)
	#print(position.y)
	if position.x < -1000:
		queue_free()

func _on_Hitbox_body_entered(body):
	#contacted with an enemy
	###play hit effect
	var direction = self.velocity.x/abs(self.velocity.x)
	var force = Vector2(0,0) #no pushback
	if (body.has_method("damageHandler")):
		body.damageHandler(damageValue, direction, force)
		queue_free()


func _on_Collision_body_entered(body):
	#contacted with the environment
	###play hit effect
	queue_free()
