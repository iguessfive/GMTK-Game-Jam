extends Control

@export var ancient_egypt: PackedScene

func _on_ancient_egypt_pressed() -> void:
    get_tree().change_scene_to_packed(ancient_egypt)
