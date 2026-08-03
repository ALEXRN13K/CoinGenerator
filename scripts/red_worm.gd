extends Node2D

signal redraw_wormcost
signal reset

func _ready() -> void:
	GameManager.worm_changed.connect(update_ui)
	update_ui()


func _on_buy_button_pressed() -> void:
	GameManager.buy_worm("red")


func update_ui() -> void:
	$Label.text = "Price: " + str(GameManager.red_worm_cost)
	$"Red Worm Count".text = "Red Worms: " + str(GameManager.red_worms)


func _on_reset() -> void:
	update_ui()
