extends Control

var has_successfully_completed_level := false

@onready var play_again_button: Button = $PlayAgainButton
@onready var dialogue_box: RichTextLabel = $DialogueBox

func _on_level_selector_button_pressed() -> void:
	get_tree().change_scene_to_file(FilePath.LEVEL_SELECTOR)

func _on_dialogue_box_show_dialogue() -> void:
	if has_successfully_completed_level:
		dialogue_box.animate_dialogue(dialogue_box.succeeded_text)
	else:
		dialogue_box.animate_dialogue(dialogue_box.failed_text)
