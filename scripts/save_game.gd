extends Node


var coins := 0
var upgrade_worm_plus_one_coin := 1
var worm_cost := 10
var worms := 1
var worm_upgrade_cost_multiplier = 1.5
var r_worm := 1
var r_worm_cost := 1500
var r_worm_upgrade_cost_multiplier = 1.5


func load_game():
	var game = get_node("/root/Game")
	var worm = get_node("/root/Game/UI/Worm")
	var red_worm = get_node("/root/Game/UI/Red Worm")
	game.coins = coins
	game.upgrade_worm_plus_one_coin = upgrade_worm_plus_one_coin
	worm.worm_cost = worm_cost
	worm.worms = worms
	worm.worm_upgrade_cost_multiplier = worm_upgrade_cost_multiplier
	red_worm.worms = r_worm
	red_worm.worm_cost = r_worm_cost
	red_worm.worm_upgrade_cost_multiplier = r_worm_upgrade_cost_multiplier
	
	
func save_game():
	var game = get_node("/root/Game")
	var worm = get_node("/root/Game/UI/Worm")
	var red_worm = get_node("/root/Game/UI/Red Worm")
	coins = game.coins
	worms = worm.worms
	worm_cost = worm.worm_cost
	upgrade_worm_plus_one_coin = game.upgrade_worm_plus_one_coin
	worm_upgrade_cost_multiplier = worm.worm_upgrade_cost_multiplier
	r_worm = red_worm.worms
	r_worm_cost = red_worm.worm_cost
	r_worm_upgrade_cost_multiplier = red_worm.worm_upgrade_cost_multiplier
	
