extends Spatial

export var target_scene: String
export var title: String


func _ready():
	Game.player_control = true


func _on_Area_body_entered(_body):
	Game.player_control = false
	Game.scene_transition(target_scene, title)
