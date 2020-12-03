extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	#loadScores()

func loadScores():
	print("AAAA")
	$"./Panel/1lab/Score1".text = str(PlayerData.scores[0]) #replace with scoreboard value.
	$"./Panel/2lab/Score2".text = str(PlayerData.scores[1]) #replace with scoreboard value.
	$"./Panel/3lab/Score3".text = str(PlayerData.scores[2]) #replace with scoreboard value.
	$"./Panel/4lab/Score4".text = str(PlayerData.scores[3]) #replace with scoreboard value.
	$"./Panel/5lab/Score5".text = str(PlayerData.scores[4]) #replace with scoreboard value.

func _on_Close_pressed():
	hide()
