extends EnemyState
class_name ConstantWander

@export var is_facing_right_ID : String = "isfacingright"
@export var enemy_movement_stats : EnemyMovmentStats

func Update(enemy : Enemy, info : Dictionary) -> Dictionary:
	if !info.has(is_facing_right_ID):
		info[is_facing_right_ID] = false
	enemy.linear_velocity.x = enemy_movement_stats.move_speed * (1 if info[is_facing_right_ID] else -1)
	return info

func Start(enemy : Enemy, info : Dictionary) -> Dictionary:
	
	return info

func Exit(enemy : Enemy, info : Dictionary) -> Dictionary:
	return info
