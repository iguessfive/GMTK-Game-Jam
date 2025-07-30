extends CharacterBody2D

@export var speed: float = 200.0

var direction: Vector2 = Vector2.ZERO
var previous_direction: Vector2 = Vector2.ZERO

@warning_ignore("unused_parameter")
func _physics_process(delta: float) -> void:
	direction = Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()
	previous_direction = direction if direction.length() > 0 else previous_direction

	if direction.length() > 0:
		velocity = direction * speed
		move_and_slide()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("throw"):
		var boomerang = preload("res://gameplay/boomerang.tscn").instantiate()
		get_tree().current_scene.add_child(boomerang)
		boomerang.position = position
		boomerang.direction = direction if direction.length() > 0 else previous_direction
