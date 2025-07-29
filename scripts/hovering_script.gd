extends Sprite2D

var time := 0.0
@export var rotation_speed := 2.0
@export var max_angle := 13.0

func  _process(delta: float) -> void:
	time += delta
	rotation_degrees = sin(time * rotation_speed) * max_angle
