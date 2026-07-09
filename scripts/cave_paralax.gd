extends Node2D

@onready var jet = get_parent().get_node("Jet")   # Finds Jet under Mines

func _process(_delta: float) -> void:
	if not jet:
		return
	
	# Full 2D follow for all layers
	for child in get_children():
		if child is ParallaxLayer:
			child.position = -jet.global_position * child.motion_scale
