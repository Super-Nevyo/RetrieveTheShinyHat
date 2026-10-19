extends Resource
class_name EnemyCollisionRaycast

@export var is_facing_right_ID : String = "isfacingright"
@export var raycast_ID : String = "myraycast"
@export var raycast_start : Vector2 = Vector2(0,0)
@export var raycast_end : Vector2 = Vector2(0,0)
@export var mask : int = 1

func check_collision(enemy : Enemy, info : Dictionary) -> bool:
	if !info.has(raycast_ID):
		var temp_raycast = RayCast2D.new()
		temp_raycast.exclude_parent = true
		temp_raycast.hit_from_inside = true
		temp_raycast.collide_with_areas = true
		temp_raycast.collision_mask = mask
		info[raycast_ID] = temp_raycast
		enemy.add_child(info[raycast_ID], false)
		temp_raycast.position = raycast_start
		temp_raycast.target_position = raycast_end
		
	
	info[raycast_ID].position.x = raycast_start.x * (1 if info[is_facing_right_ID] else -1)
	info[raycast_ID].target_position.x = raycast_end.x * (1 if info[is_facing_right_ID] else -1)
	info[raycast_ID].force_raycast_update()
	return info[raycast_ID].is_colliding()
	
