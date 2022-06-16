extends Spatial

signal clicked


func _ready():
	pass


func _on_StaticBody_input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == 1 and event.pressed:
			emit_signal("clicked")
