extends Area2D

@onready var bobs_shop := $"../../SCROLLABLE SHOP UI/Bob's Mining Pickaxe Shop Thing™"
@onready var e_button1 := $"../../E Button"

var toggle := 0

func _ready() -> void:
	e_button1.modulate.a = 0

func _on_body_entered(body: CharacterBody2D) -> void:
	var t = get_tree().create_tween()
	t.tween_property(e_button1, "modulate:a", 1, 0.3)
	toggle += 1
	
func _physics_process(delta: float) -> void:
	if toggle == 1:
		if Input.is_action_just_pressed("interact"):
			bobs_shop.emit_signal("showshop")
			

		
		
func _on_body_exited(body: CharacterBody2D) -> void:
	var t = get_tree().create_tween()
	t.tween_property(e_button1, "modulate:a", 0, 0.3)
	print("exited the radius")
	if toggle == 1:
		bobs_shop.emit_signal("closeshop")
		toggle = 0
