extends Control


func _ready():
	pass # Replace with function body.


func _on_Timer_timeout():
	Game.scene_transition("res://title/Title.tscn")
