extends Area2D

@onready var bobs_shop := $"../../SCROLLABLE SHOP UI/Bob's Mining Pickaxe Shop Thing™"
@onready var e_button1 := $"../../E Button"

var player_near := false


func _ready() -> void:
	e_button1.modulate.a = 0


func _on_body_entered(body: CharacterBody2D) -> void:

	player_near = true

	var t = get_tree().create_tween()
	t.tween_property(e_button1, "modulate:a", 1.0, 0.3)


func _physics_process(_delta):

	if player_near and Input.is_action_just_pressed("interact"):
		bobs_shop.emit_signal("showshop")


func _on_body_exited(body: CharacterBody2D) -> void:

	player_near = false

	var t = get_tree().create_tween()
	t.tween_property(e_button1, "modulate:a", 0.0, 0.3)

	bobs_shop.emit_signal("closeshop")

	print("exited the radius")
