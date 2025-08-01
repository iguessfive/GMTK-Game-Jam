class_name Level extends TileMapLayer

@export var collectible_manager: Node2D

var travelled_tiles: Dictionary = {}
var can_win := false

## Used to record the tiles the player has travelled
func add_travelled_tile(point: Vector2) -> void:
	var position_in_map = local_to_map(point)

	if not travelled_tiles.has(position_in_map) and travelled_tiles.is_empty():
		travelled_tiles[position_in_map] = true
	elif not travelled_tiles.has(position_in_map):
		travelled_tiles[position_in_map] = false
	elif travelled_tiles.has(position_in_map) and travelled_tiles[position_in_map]:
		# player has to get to this tile again after collecting all pickups to win
		if can_win:
			print("Level completed! You won.")
			# Trigger a win condition, level clear & win sfx
			$Label.visible = true
		else:
			print_debug("You cannot win yet, collect all pickups first.")
			get_tree().reload_current_scene.call_deferred()
			# Lose sfx & play again button
	else: 
		# GAME OVER condition
		print_debug("Game Over! You have already travelled this tile.")
		get_tree().reload_current_scene.call_deferred()

func get_collectible_count() -> int:
	return collectible_manager.collectible_count

func collect() -> void:
	collectible_manager.collectible_count -= 1
