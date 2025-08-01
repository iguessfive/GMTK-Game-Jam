extends CharacterBody2D

static var last_position: Vector2 = Vector2.ZERO

@export var speed: float = 200.0

var direction: Vector2 = Vector2.ZERO
var previous_direction: Vector2 = Vector2.ZERO

func _init() -> void:
	global_position = last_position

@warning_ignore("unused_parameter")
func _physics_process(delta: float) -> void:
	direction = Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()
	previous_direction = direction if direction.length() > 0 else previous_direction

	if direction.length() > 0:
		velocity = direction * speed
		move_and_slide()

	if has_player_left_screen() and get_tree().current_scene.name != "World2":
		print("Player left screen, returning to World2")
		last_position = global_position
		get_tree().change_scene_to_file("res://gameplay/world_2.tscn")

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("throw"):
		var boomerang = preload("res://gameplay/boomerang.tscn").instantiate()
		get_tree().current_scene.add_child(boomerang)
		boomerang.position = position
		boomerang.direction = direction if direction.length() > 0 else previous_direction

func has_player_left_screen() -> bool:
	if global_position.x < get_viewport_rect().position.x:
		global_position.x = get_viewport_rect().position.x
		return true
	elif global_position.x > get_viewport_rect().position.x + get_viewport_rect().size.x:
		global_position.x = get_viewport_rect().position.x + get_viewport_rect().size.x
		return true
	elif global_position.y < get_viewport_rect().position.y:
		global_position.y = get_viewport_rect().position.y
		return true
	elif global_position.y > get_viewport_rect().position.y + get_viewport_rect().size.y:
		global_position.y = get_viewport_rect().position.y + get_viewport_rect().size.y
		return true        
	return false
