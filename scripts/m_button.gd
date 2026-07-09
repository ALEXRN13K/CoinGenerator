extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = true
	
signal show_m_button


	


func _on_show_m_button() -> void:
	visible = true
	print("works")
