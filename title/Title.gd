extends Control


func _ready():
	if OS.has_feature("HTML5"):
		$VBoxContainer/QuitButton.hide()
		$VBoxContainer/GameLink.hide()

func _on_PlayButton_pressed():
	Game.scene_transition("res://game/checkin/Checkin.tscn", "Listen")


func _on_QuitButton_pressed():
	get_tree().quit()


func _on_GameLink_pressed():
	if OS.shell_open($GameLink.text) != OK:
		pass
