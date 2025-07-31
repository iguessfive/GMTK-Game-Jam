extends CharacterBody2D

@export var speed: float = 200.0

var point_current := Vector2()
var direction := Vector2()

@onready var persisent_body: Line2D = $PersistentBody
@onready var points_travelled: Array = persisent_body.points

@warning_ignore("unused_parameter")
func _physics_process(delta: float) -> void:
	direction = Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()

	if direction.length() > 0:
		velocity = direction * speed
		persisent_body.add_point(position)
		move_and_slide()
