extends Node2D

signal redraw_wormcost
signal reset

func _ready() -> void:
	GameManager.worm_changed.connect(update_ui)
	update_ui()


func _on_buy_button_pressed() -> void:
	GameManager.buy_worm("leaf")


func update_ui() -> void:
	$Label.text = "Price: " + str(GameManager.leaf_worm_cost)
	$"Leaf Worm Count".text = "Leaf Worms: " + str(GameManager.leaf_worms)


func _on_reset() -> void:
	update_ui()
