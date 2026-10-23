extends EnemyState
class_name Swimmer

@export var is_facing_right_ID : String = "isfacingright"
@export var enemy_movement_stats : EnemyMovmentStats
@export var wall_check : EnemyCollisionRaycast

@export var wave_speed : float = 2
@export var wave_strength: float = 20


func update(enemy : Enemy, info : Dictionary):
	if wall_check.check_collision(enemy,info):
		info[is_facing_right_ID] = !info[is_facing_right_ID]
	info ["swim_time"] += enemy.get_physics_process_delta_time()
	
	enemy.linear_velocity.x = enemy_movement_stats.move_speed * (1 if info[is_facing_right_ID] else -1)
	enemy.linear_velocity.y = sin(info ["swim_time"] * wave_speed) * wave_strength
	

func start(enemy : Enemy, info : Dictionary):
	if !info.has(is_facing_right_ID):
		info[is_facing_right_ID] = false
	info ["swim_time"] = 0
	

func exit(enemy : Enemy, info : Dictionary):
	return
