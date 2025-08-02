extends Area2D

func destroy() -> void:
	# Handle specific logic for collecting a pickup
	visible = false
	$AudioStreamPlayer.play()
	$AudioStreamPlayer.finished.connect(queue_free.call_deferred)
	print_debug("Pickup collected!")

	# You can add more logic here, like sfx
