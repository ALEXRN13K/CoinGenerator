extends Node2D

signal redraw_wormcost

const worm_upgrade_cost_multiplier := 1.5

var worm_cost := 1500
var worms := 0


func _ready() -> void:
	update_ui()


func _on_buy_button_pressed() -> void:
	if GameManager.coins >= worm_cost:
		GameManager.coins -= worm_cost

		worms += 1
		worm_cost *= worm_upgrade_cost_multiplier

		GameManager.add_coin_multiplier(15)
		GameManager.coins_changed.emit()

		redraw_wormcost.emit()
		update_ui()


func update_ui() -> void:
	$Label.text = "Price: " + str(worm_cost)
	$"Red Worm Count".text = "Red Worms: " + str(worms)


func _on_reset() -> void:
	worm_cost = 1500
	worms = 0
	update_ui()
