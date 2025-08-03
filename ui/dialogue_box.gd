@icon("res://assets/icons/speech.png")
class_name DialogueBox extends RichTextLabel

## DialogueBox is a UI element that displays dialogue text in a rich text format.
## It supports animated text display and can be used for level entry dialogues or end-of-level results

@warning_ignore("unused_signal")
signal show_dialogue

@export var is_level_entry_dialogue = true
@export_range(1.0, 25.0) var rate := 20.0 # words for every second
@export var voice_stream: AudioStream

@export_category("Dialogues")
@export_multiline var start_text: String
@export_multiline var failed_text: String
@export_multiline var succeeded_text: String

var audio_stream_player := AudioStreamPlayer.new()

func _init() -> void:
	add_child(audio_stream_player)
	audio_stream_player.bus = "SFX"

func _ready() -> void:
	visible_ratio = 0.0
	
	if is_level_entry_dialogue:
		animate_dialogue(start_text) # test case

func animate_dialogue(dialogue: String) -> void:
	show()
	visible_ratio = 0.0
	play_voice()
	bbcode_enabled = true
	text = "[b]" + dialogue + "[/b]"

	var tween = create_tween()
	var duration := dialogue.length() / rate
	tween.tween_property(self, "visible_ratio", 1.0, duration)
	tween.finished.connect(_on_tween_finished)

func _on_tween_finished() -> void:
	if is_level_entry_dialogue:
		get_tree().create_timer(1.0).timeout.connect(hide)

func play_voice() -> void:
	if audio_stream_player.stream != voice_stream:
		audio_stream_player.stream = voice_stream

	if audio_stream_player.is_playing():
		audio_stream_player.stop()

	audio_stream_player.bus = "SFX"
	audio_stream_player.play()
