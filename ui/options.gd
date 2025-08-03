extends Control

const SPEAKER_ON = preload("res://assets/icons/speaker_on.png")
const SPEAKER_OFF = preload("res://assets/icons/speaker_off.png")

static var is_muted: bool

func _ready() -> void:
	$SFXCheckButton.icon = SPEAKER_OFF if is_muted else SPEAKER_ON
	$SFXCheckButton.button_pressed = is_muted
	
func _on_sfx_check_button_toggled(toggled_on: bool) -> void:
	is_muted = toggled_on
	var sfx = AudioServer.get_bus_index("SFX")
	AudioServer.set_bus_mute(sfx, toggled_on)
	
	$SFXCheckButton.icon = SPEAKER_OFF if is_muted else SPEAKER_ON

func _on_level_selector_button_pressed() -> void:
	get_tree().change_scene_to_file(FilePath.LEVEL_SELECTOR) 

func _on_return_button_pressed() -> void:
	hide()
