extends EnemyState
class_name MoveForward

@export var move_speed: float

func update(enemy: Enemy, _info: Dictionary) -> void:
	var speed: float = _info.get ("lane_speed", move_speed)
	var direction := enemy.global_transform.x.normalized()

	if enemy.freeze:
		enemy.global_position += direction * speed * enemy.get_physics_process_delta_time()
	else:
		enemy.linear_velocity = direction * speed
