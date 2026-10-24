
extends EnemyState
class_name DashRecovery

@export var recovery_time : float = 1

func update(enemy : Enemy, info : Dictionary):
	if info.get("dash_hit_wall", false):
		enemy.linear_velocity = Vector2(90 if info["isfacingright"] else -90, 0)
	else:
		enemy.linear_velocity = Vector2.ZERO
	info["recovery_timer"] -= enemy.get_physics_process_delta_time()
	
	if info["recovery_timer"] <= 0:
		info["currentstate"] = enums.enemy_states.IDLE
		
func start(enemy : Enemy, info : Dictionary):
	info["recovery_timer"] = recovery_time
	enemy.linear_velocity = Vector2.ZERO
	if info.get("dash_hit_wall", false):
		info["isfacingright"] = not info["isfacingright"]
	
func exit(enemy : Enemy, info : Dictionary):
	return
