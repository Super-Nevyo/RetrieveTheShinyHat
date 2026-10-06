extends RigidBody2D
class_name Box

@export var speed : float = 0.1

func accl_toward(point : Vector2) -> void:
	gravity_scale = 0
	linear_velocity = speed * (point - position)

func throw(direction : Vector2, strength : float) -> void:
	gravity_scale = 1
	linear_velocity = strength * direction
