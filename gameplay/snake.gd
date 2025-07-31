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
	var direction_x = Input.get_axis("move_left", "move_right")
	var direction_y = Input.get_axis("move_up", "move_down")

	direction = Vector2(direction_x, direction_y).normalized()

	if abs(direction_x) > 0.0:
		print(direction_x)
		velocity.x = direction_x * speed
	elif abs(direction_y) > 0.0:
		velocity.y = direction_y * speed
	
	if direction.length() > 0:
		move_and_slide()
	
	if direction.length() > 0:
		point_current = head.global_position 
		if points_travelled.has(point_current.round()):
			points_travelled.erase(point_current)
			print("erasing")
		persisent_body.add_point(point_current) # check if point is in 
	
	
