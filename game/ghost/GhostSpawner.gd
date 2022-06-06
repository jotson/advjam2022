extends Spatial

const MAX_GHOSTS = 20
const Ghost = preload("res://game/ghost/Ghost.tscn")


func _on_spawnTimer_timeout():
	var ghost_count = get_tree().get_nodes_in_group("ghosts").size()
	if ghost_count >= MAX_GHOSTS:
		return
	
	var to_spawn = randi() % 3
	for _i in range(to_spawn):
		var g = Ghost.instance()
		g.translation = Game.get_random_position_near_player()
		get_tree().current_scene.add_child(g)
