extends EyeMovement
class_name RegionEyeStratagy
@export var start_location : Vector2
@export var half_extent : Vector2
@export var fix_distance : bool = true
@export var move_speed : float = 2

func target_player(target : Vector2, start : Vector2, iris : Sprite2D, delta : float) -> void:
	if !fix_distance:
		iris.region_rect.position = start_location - (target - start)/10
	else:
		iris.region_rect.position += delta * move_speed * (((target - start).normalized()) - iris.region_rect.position) + start_location
	#iris.region_rect.position
	pass

func idle(start : Vector2, iris : Sprite2D, delta : float, target_position : Vector2) -> Vector2:
	return target_position
