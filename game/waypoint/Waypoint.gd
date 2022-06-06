extends Spatial

func _ready():
	var t = create_tween()
	t.tween_property(self, "scale", Vector3(0, 1, 0), 5.0)
	t.tween_callback(self, "queue_free").set_delay(5.0)
