shader_type canvas_item;

void fragment() {
	// Called for every pixel the material is visible on.
	vec4 color = texture(TEXTURE, UV + vec2(.04 * TIME, .02 * TIME));
	COLOR = color;
}
