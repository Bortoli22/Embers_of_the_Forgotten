extends Node2D
var hold
var player

func _ready():
	hold = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	#check if aligned with player
	#if not, move to player

func shift():
	pass

func center(speed):
	
	pass
 

#could define behavior for left/right extremes of map


func shake(force, duration):
	#could determine a set of directions, 
	#randomize it on call and then execute movements based on force + slight randomization
	#repeat for (duration) cycles
	pass
