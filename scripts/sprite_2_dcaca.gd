extends AnimatedSprite2D

func _ready():
	save_frames()


func save_frames():

	if sprite_frames == null:
		print("No SpriteFrames found")
		return

	var folder := "res://Exported_Blocks/"

	DirAccess.make_dir_recursive_absolute(
		ProjectSettings.globalize_path(folder)
	)

	for animation in sprite_frames.get_animation_names():

		var frame_count = sprite_frames.get_frame_count(animation)

		for i in range(frame_count):

			var texture = sprite_frames.get_frame_texture(animation, i)

			if texture == null:
				continue

			var image = texture.get_image()

			var path = folder + animation + "_" + str(i) + ".png"

			image.save_png(path)

			print("Saved:", ProjectSettings.globalize_path(path))


	print("Finished exporting!")
	print("Folder location:")
	print(ProjectSettings.globalize_path(folder))
