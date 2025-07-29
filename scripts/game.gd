extends Node

signal redraw_coins(multiplier)
signal reset_multiplier

@onready var rebirths = get_node("UI/R Button/Area2D/Rebirth Menu/")
@export var coins := 0
var upgrade_worm_plus_one_coin = 1
@export var rebirth_multiplier := 1
@export var rebirth_coin_multiplier = 2
var canclick = true
func _ready() -> void:
	canclick = true
	$"UI/Coin Multiplier".text = "Coin Multiplier: " + str(1) + "X"
	$"UI/Rebirth Multiplier".hide()
	
func _on_button_pressed() -> void:
	if canclick == false:
		return
	coins += upgrade_worm_plus_one_coin * rebirth_multiplier
	$UI/Coins.text = "Coins: " + str(coins)
	print(rebirths)
	$UI/Timer.start()
	canclick = false
	
	#print(canclick)
	#print(coins)
	

func _on_timer_timeout() -> void:
	canclick = true
	#print(canclick)
	

func _on_redraw_coins(multiplier) -> void:
	$UI/Coins.text = "Coins: " + str(coins)
	upgrade_worm_plus_one_coin += multiplier
	$"UI/Coin Multiplier".text = "Coin Multiplier: " + str(upgrade_worm_plus_one_coin) + "X"
	


func _on_reset_multiplier() -> void:
	upgrade_worm_plus_one_coin = 1
	rebirth_multiplier += 1
	$"UI/Rebirth Multiplier".text = "Rebirth Multiplier: " + str(rebirth_multiplier) + "X"
	$"UI/Rebirth Multiplier".show()
	
