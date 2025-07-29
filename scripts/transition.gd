extends CanvasLayer

signal cave_change_to_black

func _ready() -> void:
	$ColorRect/AnimationPlayer.play("fade_to_normal")
	
	
	
func _on_cave_change_to_black() -> void:
	$ColorRect/AnimationPlayer.play("fade_to_black")
