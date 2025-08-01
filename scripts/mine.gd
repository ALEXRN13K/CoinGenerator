extends Node2D


@onready var mine_music: AudioStreamPlayer = $"Mine Music"



func _on_button_button_down() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")
	AudioManager.stop_music()
	
	
