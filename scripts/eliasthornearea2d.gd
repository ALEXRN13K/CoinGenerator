extends Area2D
	

func _ready():
	if GameManager.elias_dialogue_completed:
		queue_free()
