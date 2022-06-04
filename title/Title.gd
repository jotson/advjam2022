extends Control


func _on_PlayButton_pressed():
	Game.scene_transition("res://game/Kiosk.tscn")


func _on_QuitButton_pressed():
	get_tree().quit()


func _on_GameLink_pressed():
	if OS.shell_open($GameLink.text) != OK:
		pass
