extends Label

signal typing_finished

var skip_requested := false
@export var typewriting_speed: float = 0.03

var typing := false

func _ready() -> void:
	visible_characters = 0


func set_dialogue(new_text: String) -> void:
	text = new_text
	start_typing()


func start_typing() -> void:
	if typing:
		return

	typing = true
	visible_characters = 0

	var i := 0

	while i < text.length():
		
		if skip_requested:
			finish_typing()
			return

		var character := text[i]

		# Reveal this character
		visible_characters += 1

		# Check for three dots
		if text.substr(i, 3) == "...":
			await get_tree().create_timer(0.5).timeout
			i += 3
			visible_characters += 2 # reveal the other two dots
			continue

		# Check for single ellipsis character
		elif character == "…":
			await get_tree().create_timer(0.5).timeout

		elif character == "." or character == "!" or character == "?":
			await get_tree().create_timer(0.3).timeout

		elif character == ",":
			await get_tree().create_timer(0.15).timeout

		else:
			await get_tree().create_timer(typewriting_speed).timeout

		i += 1

	typing = false
	typing_finished.emit()
	
func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("skipdialogue"):
		skip_requested = true
		
func finish_typing():
	visible_characters = text.length()
	skip_requested = false
	typing = false
	typing_finished.emit()
