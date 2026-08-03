extends Node

func _ready():
	print("GameManager started")
	print("Elias:", elias_dialogue_completed)
	
var speed := 220
var jump_force := 440

signal hidearea2d
signal coins_changed
signal multiplier_changed
signal rebirth_changed
signal worm_changed

var elias_dialogue_completed := false


var player_camera: Camera2D
var elias_dialogue: Node2D
var area2delias: Area2D
var rock_barrier: StaticBody2D
var rockcollision: CollisionShape2D

var rock_1: Sprite2D
var rock_2: Sprite2D
var rock_3: Sprite2D
var rock_4: Sprite2D
var rock_5: Sprite2D
var rock_6: Sprite2D

func register_scene_refs(data: Dictionary) -> void:
	player_camera = data.get("player_camera")
	elias_dialogue = data.get("elias_dialogue")
	area2delias = data.get("area2delias")
	rock_barrier = data.get("rock_barrier")
	rockcollision = data.get("rockcollision")

	rock_1 = data.get("rock_1")
	rock_2 = data.get("rock_2")
	rock_3 = data.get("rock_3")
	rock_4 = data.get("rock_4")
	rock_5 = data.get("rock_5")
	rock_6 = data.get("rock_6")

# ============================================================
# Currency / progression
# ============================================================

var coins := 99898989
var coin_multiplier := 1
var rebirth_multiplier := 1
var rebirths := 0

var rebirth_cost := 100000
const rebirth_cost_multiplier := 2.2

const worm_upgrade_cost_multiplier := 1.5

var worm_cost := 10
var worms := 1

var red_worm_cost := 1500
var red_worms := 0

var leaf_worm_cost := 7500
var leaf_worms := 0

var archangel_worm_cost := 30000
var archangel_worms := 0

var archangel_worm_unlocked := false
var mines_unlocked := false

func add_coin():
	coins += coin_multiplier * rebirth_multiplier
	coins_changed.emit()

func add_coin_multiplier(amount:int):
	coin_multiplier += amount
	multiplier_changed.emit()

func buy_worm(type:String):
	match type:
		"worm":
			if coins >= worm_cost:
				coins -= worm_cost
				worms += 1
				worm_cost *= worm_upgrade_cost_multiplier

		"red":
			if coins >= red_worm_cost:
				coins -= red_worm_cost
				red_worms += 1
				red_worm_cost *= worm_upgrade_cost_multiplier
				coin_multiplier += 15

		"leaf":
			if coins >= leaf_worm_cost:
				coins -= leaf_worm_cost
				leaf_worms += 1
				leaf_worm_cost *= worm_upgrade_cost_multiplier

		"archangel":
			if coins >= archangel_worm_cost:
				coins -= archangel_worm_cost
				archangel_worms += 1
				archangel_worm_cost *= worm_upgrade_cost_multiplier

	multiplier_changed.emit()
	coins_changed.emit()
	worm_changed.emit()

func buy_rebirth()->bool:
	if coins < rebirth_cost:
		return false

	coins = 0
	coin_multiplier = 1
	rebirths += 1
	rebirth_multiplier += 1
	rebirth_cost *= rebirth_cost_multiplier

	if rebirths >= 1:
		archangel_worm_unlocked = true
	if rebirths >= 3:
		mines_unlocked = true

	rebirth_changed.emit()
	coins_changed.emit()
	return true

func reset():
	coins = 0
	coin_multiplier = 1
	rebirth_multiplier = 1
	worms = 1
	worm_cost = 10
	coins_changed.emit()
	worm_changed.emit()

func end_dialogue():
	elias_dialogue_completed = true
	speed = 220
	jump_force = 420

	if elias_dialogue:
		var t = get_tree().create_tween()
		t.tween_property(elias_dialogue, "modulate:a", 0.0, 0.5)

	if player_camera:
		player_camera.emit_signal("warp_from_elias")

	if area2delias:
		area2delias.queue_free()

	if rock_barrier and rock_barrier.visible:
		var t2 = get_tree().create_tween()
		for rock in [rock_1, rock_2, rock_3, rock_4, rock_5, rock_6]:
			if rock:
				t2.tween_property(rock, "modulate:a", 0.0, 0.4)

		if rockcollision:
			rockcollision.disabled = true

		rock_barrier.queue_free()

func get_save_data():
	return {
		"coins": coins,
		"coin_multiplier": coin_multiplier,
		"rebirth_multiplier": rebirth_multiplier,
		"rebirths": rebirths,
		"rebirth_cost": rebirth_cost,
		"worm_cost": worm_cost,
		"worms": worms,
		"red_worm_cost": red_worm_cost,
		"red_worms": red_worms,
		"leaf_worm_cost": leaf_worm_cost,
		"leaf_worms": leaf_worms,
		"archangel_worm_cost": archangel_worm_cost,
		"archangel_worms": archangel_worms,
		"archangel_worm_unlocked": archangel_worm_unlocked,
		"mines_unlocked": mines_unlocked,
		"elias_dialogue_completed": elias_dialogue_completed
	}
