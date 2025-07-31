extends TileMapLayer

var travelled_tiles: Dictionary = {}

## Used to show where the player can travel
func get_can_travel_tiles(point: Vector2) -> Array: # Vector2i
	var can_travel_tiles: Array = []
	var position_in_map = local_to_map(point)

	# only get tiles in cardinal directions
	for direction in [Vector2(1, 0), Vector2(-1, 0), Vector2(0, 1), Vector2(0, -1)]:
		var position_tile = position_in_map + direction
		if get_used_cells().has(position_tile):
			can_travel_tiles.append(position_tile)

	return can_travel_tiles

## Used to record the tiles the player has travelled
func add_travelled_tile(point: Vector2) -> void:
	var position_in_map = local_to_map(point)

	if not travelled_tiles.has(position_in_map):
		travelled_tiles[position_in_map] = true


## Used to move the player to a tile in the map
func move_to_tile(start_position: Vector2, direction: Vector2) -> Vector2:
	var position_in_map = local_to_map(start_position)
	print(direction)
	var new_position = position_in_map + (direction as Vector2i)
	
	if get_used_cells().has(new_position):
		print("Moving to tile: ", new_position)
		return map_to_local(new_position)
	else:
		return start_position 
