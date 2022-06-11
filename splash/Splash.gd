extends Control


func _ready():
	pass # Replace with function body.


func _input(event):
	if event.is_action_pressed("ui_cancel") or (event is InputEventMouseButton and event.is_pressed()):
		$Timer.stop()
		Game.scene_transition("res://title/Title.tscn", "", 0.5)
		

func _on_Timer_timeout():
	Game.scene_transition("res://title/Title.tscn", "", 3.0)
