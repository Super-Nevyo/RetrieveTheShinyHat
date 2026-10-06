extends RigidBody2D
class_name Box

@export var speed : float = 10
@export var float_speed : float = 10
@export var liquid_speed_reduce : float = 3
var bodies_of_water : int = 0
var floating = false

#Respawn
@export var does_respawn : bool = false
@onready var respawn_location : Vector2 = Vector2(global_position)

func _physics_process(delta: float) -> void:
	if floating:
		linear_velocity += delta * float_speed * Vector2.UP

func accl_toward(point : Vector2) -> void:
	gravity_scale = 0
	linear_velocity = speed * (point - position)

func throw(direction : Vector2, strength : float) -> void:
	if !floating:
		gravity_scale = 1
	linear_velocity = strength * direction

func change_water(entering:bool) -> void:
	if does_respawn:
		respawn()
		return
	bodies_of_water += (1 if entering else -1)
	if bodies_of_water >= 1:
		floating = true
		gravity_scale = 0
		linear_velocity = (1/liquid_speed_reduce) * linear_velocity
	else:
		floating = false
		gravity_scale = 1


func respawn():
	linear_velocity = Vector2.ZERO
	PhysicsServer2D.body_set_state(
		get_rid(),
		PhysicsServer2D.BODY_STATE_TRANSFORM,
		Transform2D.IDENTITY.translated(respawn_location)
	)
