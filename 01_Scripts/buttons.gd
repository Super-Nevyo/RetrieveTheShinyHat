extends TextureButton

@export var hover_scale: float
@export var duration: float
var hover_tween: Tween


func _ready() -> void:
	resized.connect(_centre_pivot)
	mouse_entered.connect(_animate_scale.bind(true))
	mouse_exited.connect(_animate_scale.bind(false))
	_centre_pivot.call_deferred()

func _centre_pivot() -> void:
	pivot_offset = size / 2.0

func _animate_scale(hovered: bool) -> void:
	if hover_tween:
		hover_tween.kill()
	var target := Vector2.ONE
	if hovered:
		target *= hover_scale
	hover_tween = create_tween()
	hover_tween.set_trans(Tween.TRANS_QUAD)
	hover_tween.set_ease(Tween.EASE_OUT)
	hover_tween.tween_property(self, "scale", target, duration)
