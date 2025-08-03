extends Control

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file(FilePath.LEVEL_SELECTOR)

func _on_option_button_pressed() -> void:
	get_options().show()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("menu"):
		if get_options().is_visible():
			get_options().hide()
		else:
			get_options().show()

func get_options() -> Control:
	var menu = get_tree().get_first_node_in_group("menu")
	var options = menu.get_node("Options")
	return options

func _on_play_button_mouse_entered():
	$buttonsoundeffect.play()

func _on_option_button_mouse_entered():
	$buttonsoundeffect.play()
