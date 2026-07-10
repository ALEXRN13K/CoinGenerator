extends Node

signal redraw_wormcost
signal upgrades_reset

const worm_upgrade_cost_multiplier := 1.5

var leaf_worm_cost := 7500
var leaf_worms := 0

var worm_cost := 10
var worms := 1


func buy_worm(_amount = 0) -> bool:
	if GameManager.coins >= worm_cost:
		GameManager.coins -= worm_cost

		worms += 1
		worm_cost *= worm_upgrade_cost_multiplier

		GameManager.coins_changed.emit()
		redraw_wormcost.emit()

		return true

	return false


func initialize():
	worm_cost = 10
	worms = 1
	redraw_wormcost.emit()


func reset_worm():
	initialize()
	upgrades_reset.emit()
