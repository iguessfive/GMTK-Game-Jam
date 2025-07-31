extends CharacterBody2D

@export var speed: float = 200.0
@export var grid_size: float = 64.0
@export var level: TileMapLayer

var point_current := Vector2()
var direction := Vector2()
var has_moved_finished := true
var distance_moved := 0.0

@onready var head: Sprite2D = $Head
@onready var persisent_body: Line2D = $PersistentBody
@onready var points_travelled: Array = persisent_body.points
@onready var anchor: Transform2D = $PersistentBody.transform

func _ready() -> void:
	level.add_travelled_tile(global_position)

@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	persisent_body.global_transform = anchor

@warning_ignore("unused_parameter")
func _physics_process(delta: float) -> void:

	if has_moved_finished and direction == Vector2.ZERO: # get input only when the player has finished moving
		var direction_x = Input.get_axis("move_left", "move_right")
		var direction_y = Input.get_axis("move_up", "move_down")
		if direction_x != 0.0:
			direction = Vector2(direction_x, 0).normalized()
		elif direction_y != 0.0:
			direction = Vector2(0, direction_y).normalized()

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
		level.add_travelled_tile(global_position)
		print(level.travelled_tiles)

	if direction.length() > 0:
		move_and_slide()
	
	if direction.length() > 0:
		point_current = head.global_position 
		persisent_body.add_point(point_current)
