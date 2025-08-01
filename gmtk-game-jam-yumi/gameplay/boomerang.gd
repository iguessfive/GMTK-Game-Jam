extends CharacterBody2D

@export var speed: float = 600.0
@export var distance: float = 600.0

var direction: Vector2 = Vector2.ZERO
var distance_traveled: float = 0.0
var is_returning: bool = false

func _physics_process(delta: float) -> void:
    # Change the boomerang rotation to loop back
    
    
    distance_traveled += speed * delta
    if distance_traveled <= distance:
        velocity = direction * speed
    else:
        # Reverse direction and reset distance traveled
        if is_returning:
            queue_free.call_deferred()
            is_returning = false
        direction = -direction
        distance_traveled = 0.0
        velocity = direction * speed
        is_returning = true



    move_and_slide()



