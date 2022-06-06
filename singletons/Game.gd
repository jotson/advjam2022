extends Node

const CLEAR_COLOR = Color("#2a88e2")
const TEXT_COLOR = Color("#ffffff")
const HIGHLIGHT_COLOR = Color("#ffa700")
const DARK_COLOR = Color("#333333")

var CurrentCamera: Camera = null
var Player = null

var State = {
	"kiosk": {
		"visited": false,
		"completed": false
	},
	"limbo": {
		"visited": false,
		"completed": false
	},
	"regret": {
		"visited": false,
		"completed": false
	},
	"area2": {
		"visited": false,
		"completed": false
	},
	"area3": {
		"visited": false,
		"completed": false
	},
	"area4": {
		"visited": false,
		"completed": false
	},
	"area5": {
		"visited": false,
		"completed": false
	},
}

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
	t.tween_callback($Transition/whooshSfx, "play")
	t.tween_property($Transition/Fade, "modulate", start, duration/2.0).set_delay(0.2)
	t.tween_callback($Transition, "hide")


func change_scene(scene_path: String):
	var err = get_tree().change_scene(scene_path)
	if err != OK:
		pass
	
