extends Spatial

var t: SceneTreeTween


func _ready():
	Game.CurrentCamera = $Camera
	Game.player_control = true
	
	$ClickBeacon.hide()
	
	if Game.State.meaning.ready:
		$book_pedastal/Book.hide()


func show_click_beacon():
	$ClickBeacon.show()
	

func _on_triggerArea_body_entered(_body):
	if Game.State.meaning.visits <= 0:
		if not $AnimationPlayer.is_playing():
			$AnimationPlayer.play("meaning1")
	else:
		if not $AnimationPlayer.is_playing():
			$AnimationPlayer.play("meaning3")


func _on_book_pedastal_clicked():
	if Game.State.meaning.ready:
		return
		
	$ClickBeacon.hide()
	$AnimationPlayer.play("meaning2")
	#Game.Player.stop()


func _on_triggerArea_body_exited(_body):
	$AnimationPlayer.stop()


func achievement_get():
	Game.give_orb()
	Game.State.meaning.ready = true
	Game.State.meaning.visits += 1


func take_book():
	$book_pedastal/Book.hide()
	achievement_get()
