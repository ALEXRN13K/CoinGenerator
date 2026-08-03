extends Node2D


func _ready():
	GameManager.worm_changed.connect(update_ui)
	update_ui()


func _on_buy_button_pressed():

	GameManager.buy_worm("worm")


func update_ui():

	$Label.text = "Price: " + str(GameManager.worm_cost)
	$"Worm Count".text = "Worms: " + str(GameManager.worms)
