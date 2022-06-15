extends Spatial

var t: SceneTreeTween


func _ready():
	Game.CurrentCamera = $Camera
	Game.player_control = true
	
	var start = $hands.translation
	var end = start + Vector3(0,1,0)
	
	var t = create_tween()
	t.tween_property($hands, "translation", end, 3.0)
	t.tween_property($hands, "translation", start, 3.0)
	t.set_loops()


func _on_triggerArea_body_entered(body):
	if not $dialog1.playing:
		$dialog1.play()
	t = create_tween()
	t.tween_callback(self, "achievement_get").set_delay(3.7)



func _on_triggerArea_body_exited(body):
	if t:
		t.stop()
		t = null
	$dialog1.stop()


func achievement_get():
	Game.give_orb()
	Game.State.acceptance.ready = true
	Game.State.acceptance.visits += 1
