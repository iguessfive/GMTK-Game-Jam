extends Control

@export var level_selector: PackedScene

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_packed(level_selector)

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
