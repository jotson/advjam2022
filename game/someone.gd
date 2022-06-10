extends Spatial

func _ready():
	var end = $cape.translation + Vector3(0, 0.25, 0)
	var t = create_tween()
	t.tween_property($cape, "translation", end, 1.5).set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_IN_OUT)
	t.tween_property($cape, "translation", Vector3(0,0,0), 1.5).set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_IN_OUT)
	t.set_loops()

	end = $hood.translation + Vector3(0, 0.25, 0)
	t = create_tween()
	t.tween_property($hood, "translation", end, 1.5).set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_IN_OUT).set_delay(0.1)
	t.tween_property($hood, "translation", Vector3(0,0,0), 1.5).set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_IN_OUT)
	t.set_loops()

	end = $handle.translation + Vector3(0, 0.3, 0)
	t = create_tween()
	t.tween_property($handle, "translation", end, 1.5).set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_IN_OUT).set_delay(0.2)
	t.tween_property($handle, "translation", Vector3(0,0,0), 1.5).set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_IN_OUT)
	t.set_loops()

	end = $blade.translation + Vector3(0, 0.3, 0)
	t = create_tween()
	t.tween_property($blade, "translation", end, 1.5).set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_IN_OUT).set_delay(0.2)
	t.tween_property($blade, "translation", Vector3(0,0,0), 1.5).set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_IN_OUT)
	t.set_loops()
