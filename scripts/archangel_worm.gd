extends Node2D

signal redraw_wormcost
signal show_archangel_worm

const worm_upgrade_cost_multiplier := 1.5

var worm_cost := 30000
var worms := 0
var unlocked := false


func _ready() -> void:
	hide()
	update_ui()


func _on_buy_button_pressed() -> void:
	if not unlocked:
		return

	if GameManager.coins >= worm_cost:
		GameManager.coins -= worm_cost

		worms += 1
		worm_cost *= worm_upgrade_cost_multiplier

		GameManager.add_coin_multiplier(120)
		GameManager.coins_changed.emit()

		redraw_wormcost.emit()
		update_ui()


func update_ui() -> void:
	$Label.text = "Price: " + str(worm_cost)
	$"Archangel Worm Count".text = "Archangel Worms: " + str(worms)


func unlock_archangel_worm() -> void:
	unlocked = true
	show()
	show_archangel_worm.emit()
	update_ui()


func _on_redraw_wormcost() -> void:
	update_ui()


func _on_reset() -> void:
	worm_cost = 30000
	worms = 0
	unlocked = false
	hide()
	update_ui()
