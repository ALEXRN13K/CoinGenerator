extends Camera2D

signal warp_to_elias
signal warp_from_elias

@export var end_pos = Vector2(736.0, -54.0)

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


func _on_warp_to_elias() -> void:
	var t = get_tree().create_tween()
	t.tween_property(self, "zoom", Vector2(3, 3), 1).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)



func _on_warp_from_elias() -> void:
	var t = get_tree().create_tween()
	t.tween_property(self, "zoom", Vector2(1, 1), 1).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN)
	
