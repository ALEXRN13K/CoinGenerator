extends Node2D

@onready var text = $Label

func _ready() -> void:
	var t = get_tree().create_tween()
	t.tween_property(self, "modulate:a", 0, 0.1)
	 
