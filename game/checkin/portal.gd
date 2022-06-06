extends Spatial

func _ready():
	translation.y = -10
	$Particles.emitting = false
	hide()


func _on_activationArea_body_entered(_body):
	Game.Player.queue_free()
	Game.scene_transition("res://game/limbo/Limbo.tscn")


func appear():
	show()
	$Particles.emitting = true
	var target = Vector3(translation.x, -0.5, translation.z)
	var t = create_tween()
	t.tween_property(self, "translation", target, 3.0)
