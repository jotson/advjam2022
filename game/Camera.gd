extends Camera

func _ready():
	pass


func _process(_delta):
	if Game.Player == null:
		return
		
	var player_offset = Vector3(-2, 20, 8)
	global_transform.origin = Game.Player.global_transform.origin + player_offset
	look_at(Game.Player.global_transform.origin, Vector3.UP)
