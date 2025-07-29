extends CanvasLayer


func _ready() -> void:
	$ColorRect/AnimationPlayer.play("fade_to_normal")
