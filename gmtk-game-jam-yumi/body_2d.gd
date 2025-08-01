extends Line2D

var length 
var point = Vector2()
@onready var collision_shape_2d = $Area2D/CollisionShape2D
var overlap = false

func _process(_delta):
	global_position = Vector2(0,0)
	global_rotation = 0
	
	point = get_parent().global_position
	add_point(point)
