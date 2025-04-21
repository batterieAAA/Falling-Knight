shader_type canvas_item;

uniform vec2 center = vec2(0.5, 0.5);
uniform float radius : hint_range(0.0, 2.0) = 0.5;
uniform float intensity : hint_range(0.0, 1.0) = 1.0;

void fragment() {
	vec2 uv = UV - center;
	float dist = length(uv);
	float alpha = smoothstep(radius, radius * 0.5, dist);
	vec4 color = vec4(1.0, 1.0, 1.0, alpha * intensity);
	COLOR = color;
}
