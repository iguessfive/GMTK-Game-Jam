class_name LevelLayer extends TileMapLayer

const COMPLETED_COLLECTION = preload("res://assets/sfx/completed_collection.ogg")
const COMPLETED_LEVEL = preload("res://assets/sfx/completed_level.ogg")
const FAILED_LEVEL = preload("res://assets/sfx/failed_level.ogg")

@export var player_reference: CharacterBody2D
@export var collectible_manager: Node2D
@export var dialogue_box: DialogueBox

var travelled_tiles: Dictionary = {}
var can_win := false

var sfx: AudioStreamPlayer

func _ready() -> void:
	sfx = AudioStreamPlayer.new()
	add_child(sfx)
	sfx.bus = "SFX"

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
			end(true)
		else: # if on first tile but not all pickups collected
			print_debug("You cannot win yet, collect all pickups first.")
			end(false)
			# play again or select another level
	else: 
		# GAME OVER condition
		print_debug("Game Over! You have already travelled this tile.")
		end(false)

func get_collectible_count() -> int:
	return collectible_manager.collectible_count

func collect() -> void:
	collectible_manager.collectible_count -= 1

func end(has_won: bool) -> void: # end level with win or lose condition
	# diable player input
	player_reference.disble_input()
	
	if has_won:
		sfx.stream = COMPLETED_LEVEL
		sfx.play()
	else:
		sfx.stream = FAILED_LEVEL
		sfx.play()

	if get_tree().has_group("menu"):
		var menu = get_tree().get_first_node_in_group("menu")
		var level_end = menu.get_child(1)  # assuming LevelEnd is the second child
		level_end.visible = true  # show end menu
		level_end.play_again_button.pressed.connect(restart)
		level_end.has_successfully_completed_level = has_won
		level_end.dialogue_box.is_level_entry_dialogue = false
		level_end.dialogue_box.succeeded_text = dialogue_box.succeeded_text
		level_end.dialogue_box.failed_text = dialogue_box.failed_text
		level_end.dialogue_box.show_dialogue.emit()
		print_debug("end menu shown")

func cleared_challenge() -> bool:
	sfx.stream = COMPLETED_COLLECTION
	sfx.play()
	return true if get_collectible_count() == 0 else false

func restart() -> void:
	get_tree().reload_current_scene.call_deferred()
