extends Node

const CLEAR_COLOR = Color("#2a88e2")


func _ready():
	$Transition.hide()


func scene_transition(scene_path: String, duration: float = 3.0):
	var t = get_tree().create_tween()
	
	var start = Color(1,1,1,0)
	var end = Color(1,1,1,1)
	
	$Transition/Fade.color = CLEAR_COLOR
	$Transition/Fade.modulate = start
	$Transition.show()
	t.tween_property($Transition/Fade, "modulate", end, duration/2.0)
	t.tween_callback(self, "change_scene", [scene_path])
	t.tween_property($Transition/Fade, "modulate", start, duration/2.0).set_delay(0.1)
	t.tween_callback($Transition, "hide")
	t.play()


func change_scene(scene_path: String):
	var err = get_tree().change_scene(scene_path)
	if err != OK:
		pass
	
