extends Node2D

signal redraw_wormcost
signal reset

@onready var coin_node = get_node("/root/Game")
const worm_upgrade_cost_multiplier = 1.5
var worm_cost := 0
var worms := 0

func _ready() -> void:
	initialize()
	
	
func initialize() -> void:
	worm_cost = 7500
	worms = 0
	$Label.text = "Price: " + str(worm_cost)
	$"Leaf Worm Count".text = "Leaf Worms: 0"
	

func _on_buy_button_pressed() -> void:
	var coins = coin_node.coins
	
	if coins >= worm_cost:
		worms += 1
		coin_node.coins -= worm_cost
		worm_cost = worm_cost * worm_upgrade_cost_multiplier
		emit_signal("redraw_wormcost")
		coin_node.emit_signal("redraw_coins", 60)


func _on_redraw_wormcost() -> void:
	$Label.text = "Price: " + str(worm_cost)
	$"Leaf Worm Count".text = "Leaf Worms: " + str(worms)


func _on_reset() -> void:
	initialize()
