extends Node2D

@onready var collectible_in_level: Array = get_children()
@onready var collectible_count: int = collectible_in_level.size() # Not usable in higher node ready's
