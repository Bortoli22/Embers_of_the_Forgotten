extends Node

var oscillation = .01
var alphaVal = 0
onready var glowNode = get_node("BG/Glow")
export var maxAlpha = .46


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	alphaVal += oscillation
	if alphaVal < 0 or alphaVal > maxAlpha:
		oscillation = oscillation * -1
	glowNode.modulate = Color(.58, .58, .58, alphaVal)
