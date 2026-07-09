extends Node

@onready var frames = $"../Sprite2D/AnimatedSprite2D".sprite_frames

func _ready():
	var anim = "new_animation"

	if frames == null:
		print("No SpriteFrames found!")
		return

	if not frames.has_animation(anim):
		print("Animation not found: ", anim)
		return

	for i in range(frames.get_frame_count(anim)):
		var tex = frames.get_frame_texture(anim, i)
		if tex == null:
			continue

		var img = tex.get_image()
		img.save_png("user://frame_%s_%d.png" % [anim, i])

	print("Done exporting frames!")
	
	print(OS.get_user_data_dir())
