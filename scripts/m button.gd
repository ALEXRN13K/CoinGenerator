extends Area2D



func _ready() -> void:
	get_node("Mine").hide()


func _input_event(viewport: Viewport, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		print("signal started")
		AudioManager.play_music()
		SaveGame.save_game()
		get_tree().change_scene_to_file("res://scenes/mine.tscn")
		
