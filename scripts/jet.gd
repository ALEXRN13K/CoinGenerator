extends CharacterBody2D

@export var max_dist := 1000000.0

var toggle := 0

var speed := 220
var jump_force := 420
var gravity := 900

var origin := Vector2(-145, 415)
var timer := 0.0
@onready var Elias_Thorne = $"../Elias Thorne"
@onready var fog_mat = $"../ACROSS THE FOG, TO THE LANDS BETWEEN, TO STAND BEFORE THE ELDEN RING/TextureRect".material
@onready var danger_bar = $"../UI FRONT/TextureProgressBar"

func _physics_process(delta):

	# input
	var dir := 0
	if Input.is_action_pressed("right"):
		dir += 1
	if Input.is_action_pressed("left"):
		dir -= 1
		

	# momentum movement
	var target_speed := dir * speed
	var accel := 1800
	var friction := 2200

	if dir != 0:
		velocity.x = move_toward(velocity.x, target_speed, accel * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, friction * delta)

	# gravity
	if not is_on_floor():
		velocity.y += gravity * delta

	# jump
	if Input.is_action_just_pressed("up") and is_on_floor():
		velocity.y = -jump_force

	move_and_slide()

	# fog system
	var game_pos := global_position - origin
	var dist := game_pos.length()

	var fog_alpha: float = clamp(30.0 + dist * 0.05, 30.0, 255.0)

	var color = fog_mat.get_shader_parameter("base_color")
	color.a = fog_alpha / 255.0
	fog_mat.set_shader_parameter("base_color", color)

	# debug timer
	timer += delta
	if timer >= 1.0:
		timer = 0.0
		print("game pos = X:", int(game_pos.x), "Y:", int(game_pos.y))
		print(dist)
		
	var danger: float = clamp(dist / max_dist, 0, 1)
	danger = pow(danger, 2.0)
	
	danger_bar.value = danger * 100.0

func _ready() -> void:
	var t = get_tree().create_tween()
	t.tween_property(Elias_Thorne, "modulate:a", 0, 0.1)

func _on_area_2d_body_entered(body: CharacterBody2D) -> void:
	speed = 0
	jump_force = 0
	var timer = get_tree().create_timer(1.0)   # 1 second
	await timer.timeout
	var t = get_tree().create_tween()
	t.tween_property(Elias_Thorne, "modulate:a", 1, 1.3)
	
	
