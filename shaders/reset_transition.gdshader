shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, filter_linear_mipmap;
uniform float progress : hint_range(0.0, 1.0) = 0.0;

float hash(vec2 value) {
	return fract(sin(dot(value, vec2(127.1, 311.7))) * 43758.5453123);
}

void fragment() {
	vec2 uv = SCREEN_UV;
	vec2 centre = vec2(0.5);
	vec2 direction = uv - centre;
	float distance_from_centre = length(direction);
	float radius = progress * 0.82;

	float ring = 1.0 - smoothstep(0.0, 0.035, abs(distance_from_centre - radius));
	float distortion = ring * 0.025 * (1.0 - progress);
	vec2 warped_uv = clamp(uv + normalize(direction + vec2(0.0001)) * distortion, vec2(0.0), vec2(1.0));
	vec3 scene_colour = texture(screen_texture, warped_uv).rgb;

	vec2 grid = floor(uv * vec2(100.0, 58.0));
	float glyphs = step(0.93, hash(grid + floor(progress * 72.0)));
	float scanline = step(0.985, fract(uv.y * 86.0 - progress * 34.0 + hash(vec2(grid.x, 0.0))));
	float digital_noise = max(glyphs, scanline) * smoothstep(0.0, 0.16, progress);
	float final_wash = smoothstep(0.58, 1.0, progress) * 0.72;
	float effect_strength = clamp(ring * 0.9 + digital_noise * 0.42 + final_wash, 0.0, 1.0);

	vec3 reset_green = vec3(0.32, 0.95, 0.58);
	vec3 colour = mix(scene_colour, reset_green, effect_strength);
	COLOR = vec4(colour, effect_strength);
}
