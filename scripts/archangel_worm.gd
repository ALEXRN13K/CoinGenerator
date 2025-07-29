extends Node2D

signal show_archangel_worm
signal redraw_wormcost
signal reset

@onready var coin_node = get_node("/root/Game")
@onready var rebirths = get_node("/root/Game/UI/R Button/Area2D/Rebirth Menu")
const worm_upgrade_cost_multiplier = 1.5
var worm_cost := 0
var worms := 0

func _ready() -> void:
	initialize()
	hide()
	
func initialize() -> void:
	worm_cost = 30000
	worms = 0
	$Label.text = "Price: " + str(worm_cost)
	$"Archangel Worm Count".text = "Archangel Worms: 0"
	

func _on_buy_button_pressed() -> void:
	var coins = coin_node.coins
	
	if coins >= worm_cost:
		worms += 1
		coin_node.coins -= worm_cost
		worm_cost = worm_cost * worm_upgrade_cost_multiplier
		emit_signal("redraw_wormcost")
		coin_node.emit_signal("redraw_coins", 120)


func _on_redraw_wormcost() -> void:
	$Label.text = "Price: " + str(worm_cost)
	$"Archangel Worm Count".text = "Archangel Worms: " + str(worms)


func _on_reset() -> void:
	initialize()


func _on_show_archangel_worm() -> void:
	show()
