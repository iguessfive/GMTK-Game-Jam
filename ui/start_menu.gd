extends Control

@export var level_selector: PackedScene

func _on_start_button_pressed() -> void:
    get_tree().change_scene_to_packed(level_selector)
