extends Node

@onready var rebirths = $"UI/R Button/Area2D/Rebirth Menu"

var canclick := true

func _ready():
	GameManager.coins_changed.connect(update_coins)
	GameManager.multiplier_changed.connect(update_multiplier)
	GameManager.rebirth_changed.connect(update_rebirth)
	update_ui()

func update_ui():
	$UI/Coins.text = "Coins: " + str(GameManager.coins)
	$"UI/Coin Multiplier".text = "Coin Multiplier: " + str(GameManager.coin_multiplier) + "X"

	if GameManager.rebirth_multiplier > 1:
		update_rebirth()
	else:
		$"UI/Rebirth Multiplier".hide()

func _on_button_pressed():
	if not canclick:
		return

	GameManager.add_coin()
	$UI/Timer.start()
	canclick = false

func _on_timer_timeout():
	canclick = true

func update_coins():
	$UI/Coins.text = "Coins: " + str(GameManager.coins)

func update_multiplier():
		$"UI/Coin Multiplier".text = "Coin Multiplier: " + str(GameManager.coin_multiplier) + "X"

func update_rebirth():
	$"UI/Rebirth Multiplier".text = "Rebirth Multiplier: " + str(GameManager.rebirth_multiplier) + "X"
	$"UI/Rebirth Multiplier".show()
