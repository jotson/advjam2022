extends Spatial


func _ready():
	Game.CurrentCamera = $Camera
	Game.State.limbo.visits += 1
	Game.player_control = true


func _on_doorArea_body_entered(_body):
	if Game.State.limbo.completed:
		if not $dialogReady.playing:
			Game.player_control = false
			$dialogReady.play()
			var t = create_tween()
			t.tween_callback(Game, "scene_transition", ["res://gameover.tscn"]).set_delay(16)
	else:
		if not $dialogNotready.playing:
			$dialogNotready.play()


func _on_doorArea_body_exited(_body):
	pass # Replace with function body.
