extends Spatial

func _ready():
	for w in get_children():
		var start = w.translation
		var end = start + Vector3(0, 0.1, 0)
		var t = create_tween()
		t.tween_property(w, "translation", end, 1.0 + randf()).set_trans(Tween.TRANS_CIRC)
		t.tween_property(w, "translation", start, 1.0 + randf()).set_trans(Tween.TRANS_CIRC)
		t.set_loops()
