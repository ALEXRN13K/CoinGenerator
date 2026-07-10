extends Node

signal coins_changed
signal multiplier_changed
signal rebirth_changed
signal unlock_archangel
signal unlock_mines

var coins := 99999999999999

# Coin system
var coin_multiplier := 1

# Rebirth system
var rebirths := 0
var rebirth_multiplier := 1
var rebirth_cost := 100000

const rebirth_cost_multiplier := 2.2


func add_coin():
	coins += coin_multiplier * rebirth_multiplier
	coins_changed.emit()


func add_coin_multiplier(amount: int):
	coin_multiplier += amount
	multiplier_changed.emit()


func buy_rebirth() -> bool:

	if coins < rebirth_cost:
		return false

	coins = 0
	coin_multiplier = 1

	rebirths += 1
	rebirth_multiplier += 1

	rebirth_cost *= rebirth_cost_multiplier


	coins_changed.emit()
	multiplier_changed.emit()
	rebirth_changed.emit()


	check_unlocks()

	return true


func check_unlocks():

	if rebirths >= 1:
		unlock_archangel.emit()

	if rebirths >= 3:
		unlock_mines.emit()


func reset():

	coins = 0
	coin_multiplier = 1

	rebirths = 0
	rebirth_multiplier = 1
	rebirth_cost = 100000

	coins_changed.emit()
	multiplier_changed.emit()
	rebirth_changed.emit()
