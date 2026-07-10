extends CharacterBody2D

@export var max_dist := 1000000.0

var toggledialogue := 0
var toggle := 0

var dialogue_finished := false

var speed := 220
var jump_force := 420
var gravity := 900

var origin := Vector2(-145, 415)
var timer := 0.0

# Dialogue system
var waiting_for_continue := false
var dialogue_step := 0

@onready var Elias_Thorne = $"../Elias Thorne"
@onready var fog_mat = $"../ACROSS THE FOG, TO THE LANDS BETWEEN, TO STAND BEFORE THE ELDEN RING/TextureRect".material
@onready var danger_bar = $"../UI FRONT/TextureProgressBar"
@onready var player_camera = $Camera2D
@onready var elias_dialogue = $"../UI FRONT/Elias Thorne DialogueMenu"
@onready var elias_label = get_tree().get_first_node_in_group("dialogue")
@onready var e_button = get_tree().get_first_node_in_group("dialogue_e_button")


func _physics_process(delta):

	var dir := 0

	if Input.is_action_pressed("right"):
		dir += 1
	
	if Input.is_action_pressed("left"):
		dir -= 1


	var target_speed := dir * speed
	var accel := 1800
	var friction := 2200


	if dir != 0:
		velocity.x = move_toward(velocity.x, target_speed, accel * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, friction * delta)


	if not is_on_floor():
		velocity.y += gravity * delta


	if Input.is_action_just_pressed("up") and is_on_floor():
		velocity.y = -jump_force


	move_and_slide()


	# Fog system
	var game_pos := global_position - origin
	var dist := game_pos.length()

	var fog_alpha: float = clamp(30.0 + dist * 0.05, 30.0, 255.0)

	var color = fog_mat.get_shader_parameter("base_color")
	color.a = fog_alpha / 255.0
	fog_mat.set_shader_parameter("base_color", color)


	timer += delta

	if timer >= 1.0:
		timer = 0.0
		print("game pos = X:", int(game_pos.x), "Y:", int(game_pos.y))
		print(dist)


	var danger: float = clamp(dist / max_dist, 0, 1)
	danger = pow(danger, 2.0)

	danger_bar.value = danger * 100.0


	# Dialogue continue button
	if Input.is_action_just_pressed("interact") and waiting_for_continue:
		e_button.emit_signal("visible_false")
		waiting_for_continue = false

		if dialogue_finished:
			end_dialogue()
		else:
			next_dialogue()



func _ready() -> void:

	var t = get_tree().create_tween()
	t.tween_property(Elias_Thorne, "modulate:a", 0, 0.1)

	await get_tree().process_frame

	if elias_label:
		elias_label.typing_finished.connect(_on_typing_finished)
	else:
		print("ERROR: Dialogue label not found")



func _on_area_2d_body_entered(body: CharacterBody2D) -> void:

	speed = 0
	jump_force = 0


	player_camera.emit_signal("warp_to_elias")
	print("camera signal printed")


	var t = get_tree().create_tween()

	t.tween_property(
		Elias_Thorne,
		"modulate:a",
		1.0,
		1.3
	)

	t.tween_property(
		elias_dialogue,
		"modulate:a",
		1.0,
		0.5
	)


	await t.finished


	print("fade finished")


	dialogue_step = 0
	elias_label.text = "Ah… another hollowed soul, drawn into the depths. \
	 How many rebirths did it take… \
	 before the false moon above lost its light?"

	await elias_label.start_typing()



func _on_typing_finished() -> void:

	e_button.emit_signal("visible_true")
	waiting_for_continue = true

	print("typing finished, waiting for E")



func next_dialogue() -> void:

	dialogue_step += 1

	match dialogue_step:

		1:
			elias_label.text = "I was once called Elias Thorne… a name long since devoured. Now there is only this wretched shell… still clinging to what remains of a man."
			await elias_label.start_typing()

		2:
			elias_label.text = "Behold this ruin in my chest. A sacred wound. Through it, the Vein breathes… and through it, I am slowly unmade."
			await elias_label.start_typing()

		3:
			elias_label.text = "The Crimson Miasma does not merely spread. It remembers every soul it touches. It has tasted many… and it will taste thee in full."
			await elias_label.start_typing()

		4:
				
			elias_label.text = "Thou hast climbed the ladder of rebirths, only to descend into the true belly of the world. Foolish… yet inevitable."
			await elias_label.start_typing()

		5:
			elias_label.text = "Listen… canst thou hear it? The slow, wet heartbeat beneath the stone. It beats for us now. It has claimed us both."
			await elias_label.start_typing()

		6:	
			elias_label.text = "These green tendrils… they are not mere corruption. They are the children of something far older than kings, older than gods."
			await elias_label.start_typing()
			
		7:
				
			elias_label.text = "There is no salvation here. Only different depths of damnation. I have plumbed them all… and still I remain… unfinished."
			await elias_label.start_typing()

		8:
			elias_label.text = "Take thy tools from the shattered shop if thou must. Wield them. Dig deeper. The Vein cares not for steel… only for what it devours."
			await elias_label.start_typing()

		9:	
			elias_label.text = "When the crying begins behind thine eyes… when the first coil stirs beneath thy ribs… return to me.
We shall sit together… two broken vessels… listening as the mountain itself forgets our names."
			await elias_label.start_typing()
			
		10:
			elias_label.text = "O Descended One… already the tears flow down thy face like rivers of regret. How my soul aches to see another soul walk this path I once walked in vain."
			await elias_label.start_typing()

		11:
			elias_label.text = "Thou weepest… and thy body bleeds. I see thee, Descended One. A mirror of what I was long ago. It tears what little remains of my heart to witness thy fall… so soon, so cruelly."
			await elias_label.start_typing()

		12:
			elias_label.text = "Forgive this wretched form… but when I look at thee, I mourn. I mourn the light that still clings to thy eyes. I mourn the man thou wert before the Vein claimed its due."
			await elias_label.start_typing()

		13:
				
			elias_label.text = "Do not look upon me with such sorrowful eyes, Descended One. It is too heavy a burden. I was once as thou art… and now I am nothing but a warning carved in ruined flesh."
			await elias_label.start_typing()

		14:
			elias_label.text = "If only I could spare thee this fate… but the Vein does not listen to the pleas of broken things. It only consumes. And it will consume thee… as beautifully and terribly as it consumed me."
			await elias_label.start_typing()
			
		15:
			elias_label.text = "Stay a moment, Descended One… let me look upon thy tear-stained face while it is still mostly thine. Soon the green will bloom. Soon even thy sorrow will no longer belong to thee.
…I am sorry. I am so terribly sorry."
			await elias_label.start_typing()

			dialogue_finished = true


func end_dialogue():

	dialogue_finished = false

	speed = 220
	jump_force = 420

	var t = get_tree().create_tween()
	t.tween_property(elias_dialogue, "modulate:a", 0, 0.5)

	player_camera.emit_signal("warp_from_elias")

	print("dialogue ended")

			
