extends Control

const SPEAKER_ON = preload("res://assets/icons/speaker_on.png")
const SPEAKER_OFF = preload("res://assets/icons/speaker_off.png")

func _on_sfx_check_button_toggled(toggled_on: bool) -> void:
	var sfx = AudioServer.get_bus_index("SFX")
	AudioServer.set_bus_mute(sfx, toggled_on)
	
	$SFXCheckButton.icon = SPEAKER_OFF if toggled_on else SPEAKER_ON

func _on_level_selector_button_pressed() -> void:
	get_tree().change_scene_to_file(FilePath.LEVEL_SELECTOR) 

func _on_return_button_pressed() -> void:
	hide()
