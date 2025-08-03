extends Control

const SPEAKER_ON = preload("res://assets/icons/speaker_on.png")
const SPEAKER_OFF = preload("res://assets/icons/speaker_off.png")

static var is_sfx_muted: bool = false
static var is_music_muted: bool = false

func _ready() -> void:
	%SFXCheckButton.icon = SPEAKER_OFF if is_sfx_muted else SPEAKER_ON
	%SFXCheckButton.button_pressed = is_sfx_muted

	%MusicCheckButton.icon = SPEAKER_OFF if is_music_muted else SPEAKER_ON
	%MusicCheckButton.button_pressed = is_music_muted
	
func _on_sfx_check_button_toggled(toggled_on: bool) -> void:
	is_sfx_muted = toggled_on
	var sfx = AudioServer.get_bus_index("SFX")
	AudioServer.set_bus_mute(sfx, toggled_on)
	
	%SFXCheckButton.icon = SPEAKER_OFF if is_sfx_muted else SPEAKER_ON

func _on_music_check_button_toggled(toggled_on: bool) -> void:
	is_music_muted = toggled_on
	var music = AudioServer.get_bus_index("Music")
	AudioServer.set_bus_mute(music, toggled_on)
	
	%MusicCheckButton.icon = SPEAKER_OFF if is_music_muted else SPEAKER_ON

func _on_level_selector_button_pressed() -> void:
	get_tree().change_scene_to_file(FilePath.LEVEL_SELECTOR) 

func _on_return_button_pressed() -> void:
	hide()


func _on_level_selector_button_mouse_entered():
	$SFXButton.play()


func _on_return_button_mouse_entered():
	$SFXButton.play()
