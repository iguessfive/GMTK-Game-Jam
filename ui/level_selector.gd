extends Control



func _on_ancient_egypt_pressed() -> void:
	get_tree().change_scene_to_file(FilePath.ANCIENT_EGYPT_LEVEL_1)


func _on_ancient_egypt_2_pressed() -> void:
	get_tree().change_scene_to_file(FilePath.ANCIENT_EGYPT_LEVEL_2)


func _on_egyptframe_mouse_entered():
	$GridContainer/egyptcontainer.visible = true
	
func _on_egyptframe_mouse_exited():
	$GridContainer/egyptcontainer.visible = false
