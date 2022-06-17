extends Spatial

var t: SceneTreeTween

const Candle = preload("res://game/loss/candle.tscn")


func _ready():
	Game.CurrentCamera = $Camera
	Game.player_control = true
	
	$ClickBeacon.hide()
	
	for _i in range(Game.State.loss.candles):
		make_candle()


func show_click_beacon():
	$ClickBeacon.show()
	
	
func make_candle():
	var c = Candle.instance()
	$candles.add_child(c)


func _on_candles_clicked():
	$ClickBeacon.hide()
	$AnimationPlayer.play("loss2")
	Game.State.loss.candles += 1
	make_candle()
	Game.Player.stop()
	if Game.State.loss.ready == false:
		achievement_get()


func _on_triggerArea_body_entered(_body):
	if Game.State.loss.visits <= 0:
		if not $AnimationPlayer.is_playing():
			$AnimationPlayer.play("loss1")


func _on_triggerArea_body_exited(_body):
	if $AnimationPlayer.current_animation == "loss1":
		$AnimationPlayer.stop()


func achievement_get():
	Game.give_orb()
	Game.State.loss.ready = true
	Game.State.loss.visits += 1
