extends Camera2D

@export var look_ahead_factor: float = 0.05
@export var transition_speed: float = 3.0

@onready var player = get_parent() as CharacterBody2D

func _ready() -> void:
	enabled = true
	offset = Vector2.ZERO

func _process(delta: float) -> void:
	if player == null:
		return

	var facing_h := 0
	var facing_v := 0

	if abs(player.velocity.x) > 30:
		facing_h = sign(player.velocity.x)

	if abs(player.velocity.y) > 30:
		facing_v = sign(player.velocity.y)

	var target_offset_x = look_ahead_factor * get_viewport_rect().size.x * facing_h
	var target_offset_y = look_ahead_factor * get_viewport_rect().size.y * facing_v

	var target_offset = Vector2(target_offset_x, target_offset_y)

	offset = offset.lerp(target_offset, delta * transition_speed)
