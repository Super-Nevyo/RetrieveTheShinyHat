extends AnimatedSprite2D

@export var bar: TextureProgressBar
@export var sprite_overlap: float = 2


func _process(delta: float) -> void:
	
	var frame_texture := sprite_frames.get_frame_texture(animation, frame)
	var wave_size = frame_texture.get_size() * scale
	var surface_y = bar.position.y + bar.size.y * (1.0 - bar.ratio)
	
	position.x = bar.position.x + (bar.size.x - wave_size.x) * 0.5
	position.y = surface_y - wave_size.y + sprite_overlap
	visible = bar.ratio > 0.0
