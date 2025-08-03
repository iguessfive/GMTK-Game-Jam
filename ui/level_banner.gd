extends PanelContainer

@export var banner_normal: Texture
@export var banner_hover: Texture

@export_category("Levels")
@export var level_1: PackedScene
@export var level_2: PackedScene
@export var level_3: PackedScene

static var current_level: int

@onready var banner_button: TextureButton = $BannerTexture
@onready var level_container: VBoxContainer = $VBoxContainer

func _ready() -> void:
	if banner_normal != null and banner_hover != null:
		banner_button.texture_normal = banner_normal
		banner_button.texture_hover = banner_hover

	var index: int = 0
	for button in level_container.get_children():
		index += 1
		button.pressed.connect(func() -> void: go_to_level(index))
		
func _on_banner_texture_button_down() -> void:
	banner_button.hide()
	level_container.show()

func hide_levels() -> void:
	level_container.hide()	
	banner_button.show()

func go_to_level(level: int) -> void:
	var level_scene: PackedScene = null
	
	match level:
		1:
			level_scene = level_1
		2:
			level_scene = level_2
		3:
			level_scene = level_3
		_:
			push_error("invalid level number: %d" % level)
			return
	
	if level_scene != null:
		get_tree().change_scene_to_packed(level_scene)
	else:
		push_error("level scene is null for level: %d" % level)
