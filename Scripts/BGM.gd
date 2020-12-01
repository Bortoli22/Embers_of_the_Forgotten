extends Node2D

var playing = false
var currentSong


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func play(songTitle):
	if playing:
		if (currentSong && currentSong != get_node("songTitle")):
			stop()
			currentSong = get_node("songTitle")
			playing = true
			currentSong.play()
		else:
			pass
	

func stop():
	currentSong.stop()
	playing = false

func restart():
	if playing:
		currentSong.play(0)
