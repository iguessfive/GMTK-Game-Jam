@icon("res://assets/icons/speech.png")
class_name DialogueBox extends RichTextLabel

@warning_ignore("unused_signal")
signal show_dialogue

@export var is_level_entry_dialogue = true
@export_range(1.0, 25.0) var rate := 20.0 # words for every second

@export_category("Dialogues")
@export_multiline var start_text: String
@export_multiline var failed_text: String
@export_multiline var succeeded_text: String

# there will be dialogue on level scene for a breif moment, then disapper

# when level ends, if the player has completed the level, show the success text otherwise show the failure text

func _ready() -> void:
	visible_ratio = 0.0

	if is_level_entry_dialogue:
		animate_dialogue(start_text) # test case

func animate_dialogue(dialogue: String) -> void:
	show()
	visible_ratio = 0.0
	bbcode_enabled = true
	text = "[b]" + dialogue + "[/b]"

	var tween = create_tween()
	var duration := dialogue.length() / rate
	tween.tween_property(self, "visible_ratio", 1.0, duration)
	tween.finished.connect(_on_tween_finished)

func _on_tween_finished() -> void:
	if is_level_entry_dialogue:
		get_tree().create_timer(1.0).timeout.connect(hide)
