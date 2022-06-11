extends Spatial

var t: SceneTreeTween


func _ready():
	Game.Player = $Player
	Game.CurrentCamera = $Camera
	Game.player_control = true


func _on_triggerArea_body_entered(body):
	if Game.State.reincarnation.visits <= 0:
		if not $dialog1.playing:
			$dialog1.play()
		t = create_tween()
		t.tween_callback(self, "achievement_get").set_delay(11)
	else:
		if not $dialog2.playing:
			$dialog2.play()



func _on_triggerArea_body_exited(body):
	if t:
		t.stop()
		t = null
	$dialog1.stop()
	$dialog2.stop()


func achievement_get():
	Game.State.reincarnation.ready = true
	Game.State.reincarnation.visits += 1
