extends Control



func _on_ancient_egypt_pressed() -> void:
	get_tree().change_scene_to_file(FilePath.ANCIENT_EGYPT_LEVEL_1)


func _on_ancient_egypt_2_pressed() -> void:
	get_tree().change_scene_to_file(FilePath.ANCIENT_EGYPT_LEVEL_2)


func _on_egyptframe_mouse_entered():
	$egyptcontainer.visible = true
	$AudioStreamPlayer.play()
	
func _on_egyptframe_mouse_exited():
	$egyptcontainer.visible = false


func _on_norseframe_mouse_entered():
	$norsecontainer.visible = true
	$AudioStreamPlayer.play()
func _on_norseframe_mouse_exited():
	$norsecontainer.visible = false

func _on_alchemyframe_mouse_entered():
	$alchemycontainer.visible = true
	$AudioStreamPlayer.play()
	
func _on_alchemyframe_mouse_exited():
	$alchemycontainer.visible = false

func _on_alchemy_pressed():
	get_tree().change_scene_to_file(FilePath.ALCHEMY_LEVEL_1)
