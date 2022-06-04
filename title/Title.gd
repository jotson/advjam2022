extends Control


func _on_PlayButton_pressed():
	Game.scene_transition("res://main/Main.tscn")


func _on_QuitButton_pressed():
	get_tree().quit()
