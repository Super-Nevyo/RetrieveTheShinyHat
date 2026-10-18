extends EnemyState
class_name ConstantWander

@export var is_facing_right_ID : String = "isfacingright"
@export var enemy_movement_stats : EnemyMovmentStats
@export var wall_check : EnemyCollisionRaycast
@export var ground_check : EnemyCollisionRaycast

func Update(enemy : Enemy, info : Dictionary):
	if wall_check.check_collision(enemy,info) || !ground_check.check_collision(enemy,info):
		info[is_facing_right_ID] = !info[is_facing_right_ID]
	enemy.linear_velocity.x = enemy_movement_stats.move_speed * (1 if info[is_facing_right_ID] else -1)
	return 

func Start(enemy : Enemy, info : Dictionary):
	if !info.has(is_facing_right_ID):
		info[is_facing_right_ID] = false
	return 

func Exit(enemy : Enemy, info : Dictionary):
	return 
