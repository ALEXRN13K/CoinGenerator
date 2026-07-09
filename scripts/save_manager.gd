extends Node

var game_data = {
	"coins": 0,
	"rebirths": 0,
	"rebirth_cost": 10000,
	"worms": 1,
	"red_worms": 0,
	"leaf_worms": 0,
	"worm_cost": 10,
	"red_worm_cost": 1500,
	"leaf_worm_cost": 7500,
	"current_scene": "game",
	"player_position": Vector2(-145, 415)
}

func save_game():
	var file = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	if file:
		file.store_var(game_data)

func load_game():
	if FileAccess.file_exists("user://savegame.save"):
		var file = FileAccess.open("user://savegame.save", FileAccess.READ)
		if file:
			game_data = file.get_var()

func _ready():
	load_game()

func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		save_game()
