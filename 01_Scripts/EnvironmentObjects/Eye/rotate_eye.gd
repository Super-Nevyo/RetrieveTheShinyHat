extends EyeMovement
class_name RotateEyeStratagy
@export var rotation_speed : float = 0.1
@export var wait_time : float = 2
@export var fix_rotation : float = 0

func target_player(target : Vector2, start : Vector2, iris : Sprite2D, delta : float) -> void:
	iris.rotate((atan2((start - target).y,(start - target).x) - iris.rotation + fix_rotation) * rotation_speed)
	pass

func idle(start : Vector2, iris : Sprite2D, delta : float, target_position : Vector2) -> Vector2:
	if abs(target_position.x - iris.rotation) < 0.01:
		if target_position.y < 0:
			target_position.y += wait_time
			target_position.x = sin(Time.get_ticks_msec())
			pass # pick a new random position
		else:
			target_position.y -= delta
	else:
		iris.rotate((target_position.x - iris.rotation) * rotation_speed)
	print(target_position)
	return target_position
