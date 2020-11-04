extends Button


# Declare member variables here.
var weaponID = 2


# Called when the node enters the scene tree for the first time.
func _ready():
	$"../".visible = PlayerData.rangedUnlocks[weaponID]
	self.connect("pressed", self, "_pressed")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _pressed():
	print(PlayerData.ranged[weaponID])
	PlayerData.wpnslot2 = $"../../../../Player/PlayerCenter/Sniper"
	
