extends TileMapLayer

var travelled_tiles: Dictionary = {}

## Used to record the tiles the player has travelled
func add_travelled_tile(point: Vector2) -> void:
	var position_in_map = local_to_map(point)


	if not travelled_tiles.has(position_in_map) and travelled_tiles.is_empty():
		travelled_tiles[position_in_map] = true
	elif not travelled_tiles.has(position_in_map):
		travelled_tiles[position_in_map] = false
	elif travelled_tiles.has(position_in_map) and travelled_tiles[position_in_map]:
		# player has to get to this tile again after collecting all pickups to win
		print_debug("You have already travelled this tile, but you can return after collecting all pickups.")
	else: 
		# GAME OVER condition
		print_debug("Game Over! You have already travelled this tile.")
		get_tree().reload_current_scene.call_deferred()
