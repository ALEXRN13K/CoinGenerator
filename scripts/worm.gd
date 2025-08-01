extends Node2D

signal redraw_wormcost
signal reset

@onready var coin_node = get_node("/root/Game")
var worm_upgrade_cost_multiplier = 1.5
var worm_cost := 0
var worms := 0

func _ready() -> void:
	SaveGame.load_game()
	initialize()

func initialize() -> void:
	$Label.text = "Price: " + str(worm_cost)
	$"Worm Count".text = "Worms: " + str(worms)

func _on_buy_button_pressed() -> void:
	var coins = coin_node.coins
	if coins >= worm_cost:
		coin_node.coins -= worm_cost
		worm_cost = worm_cost * worm_upgrade_cost_multiplier
		worms += 1
		emit_signal("redraw_wormcost")
		coin_node.emit_signal("redraw_coins", 1)


func _on_redraw_wormcost() -> void:
	$Label.text = "Price: " + str(worm_cost)
	$"Worm Count".text = "Worms: " + str(worms)
	

func _on_reset() -> void:
	initialize()
