extends Sprite2D

signal visible_true
signal visible_false

func _ready() -> void:
	visible = false

func _on_visible_true() -> void:
	visible = true
	
func _on_visible_false() -> void:
	visible = false
