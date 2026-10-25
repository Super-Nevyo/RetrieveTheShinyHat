extends EnemyState
class_name Dasher

@export var is_facing_right_ID : String = "isfacingright"
@export var wall_check : EnemyCollisionRaycast
@export var switch_check : EnemyCollisionRaycast

@export var dash_speed : float = 300
@export var dash_distance: float = 250


func update(enemy : Enemy, info : Dictionary):
	var distance = enemy.global_position.distance_to(info ["dash"])
	
	#if wall_check.check_collision(enemy, info):
	var direction = 1 if info[is_facing_right_ID] else -1
	if enemy.test_move(enemy.global_transform, Vector2(direction * 12, 0)):
		info["dash_hit_wall"] = true
		info ["currentstate"] = enums.enemy_states.RETURN
		return
	if distance >= dash_distance:
		info ["currentstate"] = enums.enemy_states.RETURN
		return
		
	if switch_check.check_collision(enemy, info):
		var switch_hit = info[switch_check.raycast_ID].get_collider()
		if switch_hit is AttackReceiver:
			switch_hit.receive_attack()
			info["currentstate"] = enums.enemy_states.RETURN
			return
		
	enemy.linear_velocity = Vector2(
		dash_speed * (1 if info[is_facing_right_ID] else -1),0)

func start(enemy : Enemy, info : Dictionary):
	info["dash_hit_wall"] = false
	enemy.gravity_scale = 0
	info["dash"] = enemy.global_position
	enemy.linear_velocity = Vector2.ZERO

func exit(enemy : Enemy, info : Dictionary):
	enemy.linear_velocity = Vector2.ZERO
