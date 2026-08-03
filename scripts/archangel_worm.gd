extends Node2D

signal redraw_wormcost
signal reset

const worm_upgrade_cost_multiplier := 1.5

var worm_cost := 30000
var worms := 0


func _ready() -> void:
	if GameManager.archangel_worm_unlocked:
		show()
	else:
		hide()

	initialize()


func initialize() -> void:
	worm_cost = 30000
	worms = 0
	
	$Label.text = "Price: " + str(worm_cost)
	$"Archangel Worm Count".text = "Archangel Worms: " + str(worms)


func _on_buy_button_pressed() -> void:
	if GameManager.coins >= worm_cost:
		
		GameManager.coins -= worm_cost
		
		worms += 1
		worm_cost *= worm_upgrade_cost_multiplier
		
		GameManager.coins_changed.emit()
		redraw_wormcost.emit()


func _on_redraw_wormcost() -> void:
	$Label.text = "Price: " + str(worm_cost)
	$"Archangel Worm Count".text = "Archangel Worms: " + str(worms)


func _on_reset() -> void:
	initialize()
