shader_type canvas_item;


uniform sampler2D image_in;

void fragment() {
	// Called for every pixel the material is visible on.
	vec4 tex_in = texture(image_in, UV);
}
