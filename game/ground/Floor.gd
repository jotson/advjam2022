extends StaticBody

func _ready():
	pass


func _on_Floor_input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton:
		event = event as InputEventMouseButton
		if event.is_pressed() and event.button_index == 1:
			Game.Player.move_to(position)
