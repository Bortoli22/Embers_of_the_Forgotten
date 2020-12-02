extends Node2D

var playing = false
var currentSong = null
var songList = ["BGM-Merchant","BGM-Stage-A","BGM-Stage-B","BGM-Stage-C","BGM-Stage-D"]

func _ready():
	var song = GameData.current_level % songList.size()
	play(songList[song])
	
func play(songTitle):
	if playing:
		if (currentSong && currentSong != get_node(songTitle)):
			stop()
		else:
			pass
	currentSong = get_node(songTitle)
	playing = true
	currentSong.play()
	

func stop():
	currentSong.stop()
	playing = false

func restart():
	if playing:
		currentSong.play(0)
