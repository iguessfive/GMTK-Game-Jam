extends Control

var has_successfully_completed_level := false

@onready var play_again = $"HBoxContainer/VBoxContainer/play again"
@onready var dialogue_box: RichTextLabel = $DialogueBox


func _on_dialogue_box_show_dialogue() -> void:
	if has_successfully_completed_level:
		dialogue_box.animate_dialogue(dialogue_box.succeeded_text)
	else:
		dialogue_box.animate_dialogue(dialogue_box.failed_text)


func _on_play_again_pressed():
	pass # Replace with function body.


func _on_other_level_pressed() -> void:
	get_tree().change_scene_to_file(FilePath.LEVEL_SELECTOR)
