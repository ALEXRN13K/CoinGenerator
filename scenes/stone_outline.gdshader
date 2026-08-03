shader_type canvas_item;

uniform vec4 outline_color : source_color = vec4(0.0, 0.0, 0.0, 1.0);
uniform int outline_size = 1;

void fragment()
{
	vec4 tex = texture(TEXTURE, UV);

	// Draw the original sprite.
	if (tex.a > 0.0)
	{
		COLOR = tex;
	}
	else
	{
		float found = 0.0;

		for (int x = -outline_size; x <= outline_size; x++)
		{
			for (int y = -outline_size; y <= outline_size; y++)
			{
				vec2 offset = vec2(float(x), float(y)) * TEXTURE_PIXEL_SIZE;

				found = max(
					found,
					texture(TEXTURE, UV + offset).a
				);
			}
		}

		if (found > 0.0)
			COLOR = outline_color;
		else
			COLOR = vec4(0.0);
	}
}