shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, filter_linear_mipmap;
uniform float progress : hint_range(0.0, 1.0) = 0.0;

float hash(vec2 value) {
	return fract(sin(dot(value, vec2(127.1, 311.7))) * 43758.5453123);
}

void fragment() {
	vec2 uv = SCREEN_UV;
	vec3 scene_colour = texture(screen_texture, uv).rgb;

	vec2 grid = floor(uv * vec2(100.0, 58.0));
	float pixel_fill = step(hash(grid), progress);
	float background_wash = progress * 0.16;
	float effect_strength = max(background_wash, pixel_fill * progress);

	vec3 reset_green = vec3(0.32, 0.95, 0.58);
	vec3 colour = mix(scene_colour, reset_green, effect_strength);
	COLOR = vec4(colour, effect_strength);
}
