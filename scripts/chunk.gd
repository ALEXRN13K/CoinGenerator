extends Node2D

var caves

@export var stone_scene: PackedScene

var chunk_position: Vector2i

const BLOCK_SIZE := 57
const WIDTH := 32
const HEIGHT := 32


func _ready():
	caves = get_parent().get_parent().get_parent()
	print(caves.name)

	generate_blocks()


func generate_blocks():

	for x in WIDTH:
		for y in HEIGHT:

			var world_position = Vector2i(
				chunk_position.x * WIDTH + x,
				chunk_position.y * HEIGHT + y
			)

			if is_spawn_area(world_position):
				print("REMOVED BLOCK:", world_position)
				continue

			create_stone(Vector2i(x,y))

func create_stone(local_position: Vector2i):

	var stone = stone_scene.instantiate()

	stone.position = Vector2(
		local_position.x * BLOCK_SIZE + BLOCK_SIZE / 2,
		local_position.y * BLOCK_SIZE + BLOCK_SIZE / 2
	)

	$Blocks.add_child(stone)
	
	
func is_spawn_area(pos: Vector2i) -> bool:

	var min_x := -4
	var max_x := 13
	var min_y := 4
	var max_y := 8

	return (
		pos.x >= min_x and
		pos.x <= max_x and
		pos.y >= min_y and
		pos.y <= max_y
	)
