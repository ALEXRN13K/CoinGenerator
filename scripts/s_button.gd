extends Node2D


func _ready() -> void:
	pass
	
func _physics_process(delta: float) -> void:
	if get_tree().current_scene.scene_file_path == "res://scenes/mines.tscn":
		visible = true
	else:
		visible = false
		print("nooo wisible uwuu")
