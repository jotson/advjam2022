extends Node

const CLEAR_COLOR = Color("#2a88e2")
const TEXT_COLOR = Color("#ffffff")
const HIGHLIGHT_COLOR = Color("#ffa700")
const DARK_COLOR = Color("#333333")

var CurrentCamera: Camera = null
var Player = null setget set_player, get_player
var player_control = true


var State = {
	"checkin": {
		"visited": false,
		"completed": false
	},
	"limbo": {
		"visited": false,
		"ready": false
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
	

func get_random_position_near_player() -> Vector3:
	if Game.Player == null:
		return get_random_position()
		
	var SIZE = 30
	var x = randf() * SIZE - SIZE/2
	var y = 1.5
	var z = randf() * SIZE - SIZE/2
	
	return Game.Player.translation + Vector3(x,y,z)
	

func get_random_position() -> Vector3:
	var SIZE = 100
	var x = randf() * SIZE - SIZE/2
	var y = 1.5
	var z = randf() * SIZE - SIZE/2
	
	return Vector3(x,y,z)
	

func set_player(value):
	Player = value


func get_player():
	if not is_instance_valid(Player):
		Player = null
	return Player
