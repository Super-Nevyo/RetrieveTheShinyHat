extends EnemyState
class_name MoveForward

@export var move_speed: float

func update(enemy: Enemy, _info: Dictionary) -> void:
	var speed: float = _info.get ("lane_speed", move_speed)
	enemy.linear_velocity = Vector2(speed, 0)
