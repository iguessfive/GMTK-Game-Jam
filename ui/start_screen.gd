extends Control

@export var level_selector: PackedScene

func _on_play_pressed() -> void:
	get_tree().change_scene_to_packed(level_selector)


func _on_options_pressed():
	pass # Replace with function body.
