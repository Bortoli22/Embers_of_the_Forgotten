extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_released("pause"):
		if GameData.paused:
			hide()
			GameData.paused = false
		else:
			GameData.paused = true
			$MenuSFX.play("open")
			show()


func _on_Resume_pressed():
	buttonsound()

func _on_Restart_pressed():
	buttonsound()

func _on_MainMeu_pressed():
	buttonsound()

func _on_ControlRebind_pressed():
	buttonsound()
	
func buttonsound():
	$MenuSFX.play("select1")
