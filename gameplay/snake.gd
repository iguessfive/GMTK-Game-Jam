extends CharacterBody2D

@export var speed: float = 200.0
@export var grid_size: float = 64.0
@export var level: TileMapLayer
@export var hazards: TileMapLayer

var direction := Vector2()
var has_moved_finished := true
var distance_moved := 0.0

@onready var head: Sprite2D = $Head
@onready var persisent_body: Line2D = $PersistentBody
@onready var points_travelled: Array = persisent_body.points
@onready var anchor: Transform2D = $PersistentBody.transform
@onready var collector := $Collector

func _ready() -> void:
	if level != null:
		level.add_travelled_tile(global_position)

@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	persisent_body.global_transform = anchor

@warning_ignore("unused_parameter")
func _physics_process(delta: float) -> void:

	if has_moved_finished and direction == Vector2.ZERO: # get input only when the player has finished moving
		var direction_x = Input.get_axis("move_left", "move_right")
		var direction_y = Input.get_axis("move_up", "move_down")
		direction = Vector2(direction_x, direction_y).normalized()

	if direction.x > 0:
		head.rotation_degrees = 90
	elif direction.x < 0:
		head.rotation_degrees = -90
	elif direction.y > 0:
		head.rotation_degrees = -180
	elif direction.y < 0:
		head.rotation_degrees = 0

	velocity = Vector2.ZERO
	if abs(direction.x) > 0.0:
		velocity.x = direction.x * speed
		has_moved_finished = false
	elif abs(direction.y) > 0.0:
		velocity.y = direction.y * speed
		has_moved_finished = false
	
	if not has_moved_finished:
		distance_moved += speed * delta

	if distance_moved >= grid_size:
		distance_moved = 0.0
		has_moved_finished = true
		direction = Vector2.ZERO
		level.add_travelled_tile(global_position) # record the tile travelled

	if direction.length() > 0:
		move_and_slide()
	
	if direction.length() > 0:
		persisent_body.add_point(head.global_position )

func _on_collector_area_entered(area: Area2D) -> void:
	if area.is_in_group("collectible"):
		area.destroy()  # handle pickups specific logic, sfx, animation, etc.
		# if all items are collected, you can allow for level completion
		level.collect()
		print(level.get_collectible_count())
		if level.get_collectible_count() == 0:
			print_debug("You can win now, all pickups collected!")
			level.can_win = true # once all items are collected

func _on_hazard_sensor_body_entered(body: Node2D) -> void:
	if body.is_in_group("hazards"):
		print_debug("You have entered a hazard area!")
		get_tree().reload_current_scene.call_deferred()
