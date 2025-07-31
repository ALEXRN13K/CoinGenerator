extends Node


var coins := 0
var upgrade_worm_plus_one_coin := 0

func load_game():
	var game = get_node("/root/Game")
	game.coins = coins
	#game.upgrade_worm_plus_one_coin = upgrade_worm_plus_one_coin
	
func save_game():
	var game = get_node("/root/Game")
	coins = game.coins
	#upgrade_worm_plus_one_coin = game.upgrade_worm_plus_one_coin
