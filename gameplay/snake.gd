extends CharacterBody2D

@export var speed: float = 200.0

var point_current := Vector2()
var direction := Vector2()

@onready var head: Sprite2D = $Head
@onready var persisent_body: Line2D = $PersistentBody
@onready var points_travelled: Array = persisent_body.points
@onready var anchor: Transform2D = $PersistentBody.transform

@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	persisent_body.global_transform = anchor

@warning_ignore("unused_parameter")
func _physics_process(delta: float) -> void:
	direction = Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()

	if direction.length() > 0:
		velocity = direction * speed
		point_current = head.global_position 
		if points_travelled.has(point_current.round()):
			points_travelled.erase(point_current)
			print("erasing")
		persisent_body.add_point(point_current) # check if point is in 
		move_and_slide()
