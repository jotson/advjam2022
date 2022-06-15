extends Spatial

var t: SceneTreeTween


func _ready():
	Game.CurrentCamera = $Camera
	Game.player_control = true


func _on_triggerArea_body_entered(_body):
	if Game.State.judgement.visits <= 0:
		if not $dialog1.playing:
			$dialog1.play()
		t = create_tween()
		# warning-ignore:return_value_discarded
		t.tween_callback(self, "achievement_get").set_delay(21)
	else:
		if not $dialog2.playing:
			$dialog2.play()



func _on_triggerArea_body_exited(_body):
	if t:
		t.stop()
		t = null
	$dialog1.stop()
	$dialog2.stop()


func achievement_get():
	Game.give_orb()
	Game.State.judgement.ready = true
	Game.State.judgement.visits += 1
