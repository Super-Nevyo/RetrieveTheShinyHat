extends puzzle_activated
class_name PipePiece

@export var shape: enums.pipe_shapes
@export var mouth_side: enums.pipe_side

func activate_puzzle(id: int, amount: float) -> void:
	if id == signal_id and id >= 0:
		rotation_degrees = wrapf(rotation_degrees + 90.0 * amount, 0.0, 360.0)
