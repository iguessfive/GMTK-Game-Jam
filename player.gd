extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var PastLocation : Array

func _physics_process(delta):

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	# As good practice, you should replace UI actions with custom gameplay actions.
	var height = Input.get_axis("ui_up", "ui_down")
	if height:
		velocity.y = height * SPEED
	else:
		velocity.y = move_toward(velocity.x, 0, SPEED)


	move_and_slide()
