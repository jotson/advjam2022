extends Spatial

var t: SceneTreeTween


func _ready():
	Game.Player = $Player
	Game.CurrentCamera = $Camera
	Game.State.judgement.visits += 1
	Game.player_control = true


func _on_triggerArea_body_entered(body):
	if Game.State.judgement.visits <= 1:
		if not $dialog1.playing:
			$dialog1.play()
		t = create_tween()
		t.tween_callback(self, "achievement_get")
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
	Game.State.judgement.ready = true
