extends Spatial

var index = 0
var original_position

func _ready():
	$AnimatedSprite3D.play("default")
	index = get_tree().get_nodes_in_group("candles").size()
	original_position = Vector3(randf() * 0.5 * index, 2.0, randf() * 0.5 * index)
	transform.origin = original_position


func _physics_process(_delta):
	# Do something amazing I guess
	transform.origin = original_position - Vector3(0, sin(OS.get_ticks_msec() / 200.0 + index * 0.13), 0) * 0.25
