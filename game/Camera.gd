extends Camera

func _ready():
	pass


func _process(delta):
	var player_offset = Vector3(-5, 35, 10)
	global_transform.origin = Game.Player.global_transform.origin + player_offset
	look_at(Game.Player.global_transform.origin, Vector3.UP)
