extends Area2D

func _ready() -> void:
	get_node("Rebirth Menu").hide()
	
func _input_event(viewport: Viewport, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		get_node("Rebirth Menu").show()
