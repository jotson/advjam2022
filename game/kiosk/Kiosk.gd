extends Spatial

func _ready():
	Game.CurrentCamera = $Camera
	Game.Player = $Player
