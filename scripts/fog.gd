extends WorldEnvironment

@export var player_path: NodePath

@export var origin := Vector2(-145, 415)

@export var near_density := 0.005
@export var far_density := 0.08

@export var max_distance := 2000.0

var player

func _ready():
	player = get_node(player_path)

func _process(delta):
	if player == null:
		return

	var game_pos = player.global_position - origin

	# THIS is the key: radial distance
	var dist = game_pos.length()

	var t = clamp(dist / max_distance, 0.0, 1.0)

	environment.fog_density = lerp(near_density, far_density, t)
