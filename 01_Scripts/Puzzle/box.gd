extends RigidBody2D
class_name Box

@export var speed : float = 10
@export var float_speed : float = 10
@export var liquid_speed_reduce : float = 3
var bodies_of_water : int = 0
var floating : bool = false

#Respawn
@export var does_respawn : bool = false
@onready var respawn_location : Vector2 = Vector2(global_position)

#ink
var attached_ink: Area2D = null
var ignored_ink: Area2D = null
var ink_offset: Vector2 = Vector2.ZERO
var held_by_player: bool = false

func _ready() -> void:
	process_physics_priority = 100

func _physics_process(delta: float) -> void:
	if is_instance_valid(ignored_ink):
		if not ignored_ink.overlaps_body(self):
			ignored_ink = null
	
	if is_instance_valid(attached_ink):
		global_position = attached_ink.to_global(ink_offset)
		return
	
	if floating:
		linear_velocity += delta * float_speed * Vector2.UP

func attach_to_ink(ink: Area2D) -> bool:
	if held_by_player or floating:
		return false
	
	if is_instance_valid(attached_ink):
		return false

	if ink == ignored_ink:
		return false

	attached_ink = ink
	ink_offset = ink.to_local(global_position)
	linear_velocity = Vector2.ZERO
	angular_velocity = 0.0
	freeze_mode = RigidBody2D.FREEZE_MODE_KINEMATIC
	freeze = true

	return true

func release_from_ink(ink: Area2D) -> void:
	if attached_ink != ink:
		return
	
	_detach_ink()

func _detach_ink() -> void:
	
	attached_ink = null
	freeze = false
	sleeping = false

func accl_toward(point : Vector2) -> void:
	held_by_player = true
	
	if is_instance_valid(attached_ink):
		ignored_ink = attached_ink
		_detach_ink()
	
	gravity_scale = 0
	linear_velocity = speed * (point - global_position)

func throw(direction : Vector2, strength : float) -> void:
	held_by_player = false
	
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
	_detach_ink()
	held_by_player = false
	ignored_ink = null
	
	linear_velocity = Vector2.ZERO
	PhysicsServer2D.body_set_state(
		get_rid(),
		PhysicsServer2D.BODY_STATE_TRANSFORM,
		Transform2D.IDENTITY.translated(respawn_location)
	)
