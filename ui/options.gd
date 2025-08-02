extends Control


func _on_level_selector_button_pressed() -> void:
	get_tree().change_scene_to_file(FilePath.LEVEL_SELECTOR)
