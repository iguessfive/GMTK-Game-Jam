extends Control

const LEVEL_CLEARED_TEXT = "Level Cleared!"
const LEVEL_FAILED_TEXT = "Level Failed!"

var has_successfully_completed_level: bool = false

@onready var play_again_button := $PlayAgainButton
@onready var dialogue_box: RichTextLabel = $DialogueBox

func _on_level_selector_button_pressed() -> void:
	get_tree().change_scene_to_file(FilePath.LEVEL_SELECTOR)

func _on_dialogue_box_show_dialogue() -> void:
	$ResultLabel.text = LEVEL_CLEARED_TEXT if has_successfully_completed_level else LEVEL_FAILED_TEXT
	if has_successfully_completed_level:
		dialogue_box.animate_dialogue(dialogue_box.succeeded_text)
	else:
		dialogue_box.animate_dialogue(dialogue_box.failed_text)
