extends Control

func _ready() -> void:
	_on_sfx_check_button_toggled(true)

func _on_sfx_check_button_toggled(toggled_on: bool) -> void:
	var sfx = AudioServer.get_bus_index("SFX")
	AudioServer.set_bus_mute(sfx, toggled_on)

func _on_level_selector_button_pressed() -> void:
	get_tree().change_scene_to_file(FilePath.LEVEL_SELECTOR) 
