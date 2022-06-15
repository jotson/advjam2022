extends Spatial

var index = 0
var offset: Vector3 = Vector3.ZERO


func _ready():
	index = get_tree().get_nodes_in_group("orbs").size()


func _physics_process(_delta):
	# Orbit or follow the player
	var new_offset = Game.Player.global_transform.basis.z * (index + 1.0)
	offset = lerp(offset, new_offset, 0.1 / (index * 0.5))
	offset.y = sin(index - float(OS.get_ticks_msec()) / 200.0) * 0.5 - 4.0
	global_transform.origin = Game.Player.global_transform.origin - offset
	
