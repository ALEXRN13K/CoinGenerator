extends Node2D

@export var chunk_offset := Vector2.ZERO
@onready var spawn_protection = $"../SpawnProtection"

@export var chunk_scene: PackedScene

@onready var chunks = $Chunks

const BLOCK_SIZE := 57
const CHUNK_WIDTH := 32
const CHUNK_HEIGHT := 32

const CHUNK_SIZE := BLOCK_SIZE * CHUNK_WIDTH
const LOAD_DISTANCE := 1
var player: CharacterBody2D


var loaded_chunks := {}


func _ready():
	print("CAVES _ready")

	player = get_tree().get_first_node_in_group("player")

	print(player)
	
	create_chunk(Vector2i(0,0))
	create_chunk(Vector2i(1,0))
	create_chunk(Vector2i(0,1))


func _process(delta):

	if player == null:
		return

	var player_chunk := world_to_chunk(player.global_position)

	load_chunks_around(player_chunk)


func world_to_chunk(position: Vector2) -> Vector2i:

	return Vector2i(
		floor(position.x / CHUNK_SIZE),
		floor(position.y / CHUNK_SIZE)
	)


func load_chunks_around(center: Vector2i):

	for x in range(
		center.x - LOAD_DISTANCE,
		center.x + LOAD_DISTANCE + 1
	):

		for y in range(
			center.y - LOAD_DISTANCE,
			center.y + LOAD_DISTANCE + 1
		):

			var chunk_position := Vector2i(x, y)
			
			if not loaded_chunks.has(chunk_position):
				create_chunk(chunk_position)


func create_chunk(position: Vector2i):
	
	var chunk = chunk_scene.instantiate()
	chunk.chunk_position = position
	
	chunk.position = Vector2(
	position.x * CHUNK_SIZE,
	position.y * CHUNK_SIZE
) + chunk_offset

	chunks.add_child(chunk)
	print("Creating chunk:", position)

	loaded_chunks[position] = chunk
	
func is_position_protected(pos: Vector2i) -> bool:

	var block_rect := Rect2(
		pos.x * BLOCK_SIZE,
		pos.y * BLOCK_SIZE,
		BLOCK_SIZE,
		BLOCK_SIZE
	)

	var shape := spawn_protection.get_node("caca") as CollisionShape2D
	var protection_rect := Rect2(
		spawn_protection.global_position - shape.shape.size / 2,
		shape.shape.size
	)

	return block_rect.intersects(protection_rect)
