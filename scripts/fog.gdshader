shader_type canvas_item;

uniform vec4 base_color : source_color;
global uniform float location_fade;   // This should be controlled from GDScript (0.0 = no fog, 1.0 = max fog)

void fragment() {
    // Moving fog texture (keeps the nice organic movement)
    vec3 fog_color_1 = texture(TEXTURE, vec2(UV.x / 2.0 + TIME / 100.0, UV.y / 4.0 - TIME / 100.0)).rgb;
    vec3 fog_color_2 = texture(TEXTURE, vec2(UV.x / 2.0 + 0.5 + TIME / 50.0, UV.y / 4.0 + 0.5 - TIME / 160.0)).rgb;
    vec3 fog_color_3 = texture(TEXTURE, vec2(UV.x / 2.0 + 0.25 + TIME / 25.0, UV.y / 4.0 - 0.25 + TIME / 160.0)).rgb;
    
    vec3 fog_color = mix(
        fog_color_3,
        mix(fog_color_1, fog_color_2, 0.5),
        0.7
    );
    
    // Removed TIME-based fade. Now fully controlled by distance
    float intensity = location_fade;                    // 0.0 = clean, 1.0 = full scary red
    
    float alpha = base_color.a * fog_color.r * 1.5 * intensity;
    
    COLOR = vec4(
        fog_color * base_color.rgb * intensity,
        alpha
    );
}