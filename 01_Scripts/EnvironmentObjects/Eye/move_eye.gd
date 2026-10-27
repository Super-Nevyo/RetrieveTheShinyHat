extends EyeMovement
class_name MoveEyeStratagy
@export var fix_distance : bool = true
@export var move_speed : float = 2
@export var max_distance : float = 10

func target_player(target : Vector2, start : Vector2, iris : Sprite2D, delta : float) -> void:
	if !fix_distance:
		iris.position += delta * move_speed * (((target - start) / max_distance) - iris.position) 
	else:
		iris.position += delta * move_speed * (((target - start).normalized()) * max_distance - iris.position) 

func idle(start : Vector2, iris : Sprite2D, delta : float, target_position : Vector2) -> Vector2:
	if (!fix_distance && (((target_position - start) / max_distance) - iris.position).length() < 0.1) || (fix_distance && (((target_position - start).normalized()) * max_distance - iris.position).length() < 0.1) || target_position == Vector2.ZERO:
			target_position = Vector2(sin(Time.get_ticks_msec() * 311) * 300, sin(Time.get_ticks_msec() * 13) * 300) + start
	target_player(target_position, start, iris, delta)
	return target_position
