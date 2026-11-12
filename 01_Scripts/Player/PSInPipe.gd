class_name PSInPipe
extends PlayerState

var current_pipe: PipePiece
var pipe_direction: Vector2
var pipe_speed: float = 200
var arrived_from_pipe: bool = false
var leaving_pipe: bool = false
var exit_target: Vector2
var sprite_pipe: Vector2

const exit_distance: float = 56
var hitbox: CollisionShape2D

func _init(player:PlayerController):
	Player = player

func Enter():
	arrived_from_pipe = false
	leaving_pipe = false
	Player.finish_attack()
	Player.velo = Vector2.ZERO
	Player.velocity = Vector2.ZERO
	hitbox = Player.get_node("PlayerHitBox") as CollisionShape2D
	sprite_pipe = Player.player_anim.position
	Player.player_anim.position = hitbox.position
	
	Player.player_anim.play("InPipe")
	pipe_direction = -current_pipe.exit_direction()

func Exit():
	Player.player_anim.position = sprite_pipe
	current_pipe = null

func Update(delta:float):
	var center = hitbox.global_position
	var target = exit_target if leaving_pipe else current_pipe.global_position
	var next_center = center.move_toward(target,pipe_speed * delta)
	Player.global_position += next_center - center
	
	if not next_center.is_equal_approx(target): return
	if leaving_pipe:
		if Player.liquid_counter.bodies_of_water > 0:
			Player.MyStateMachine.ChangeState(Player.MyStateMachine.Swim)
		else: Player.MyStateMachine.ChangeState(Player.MyStateMachine.Fall)
		return
		
	get_in_pipe()

func get_in_pipe() -> void:
	if arrived_from_pipe and start_exit(): return
	var direction: Vector2 = pressed_direction()
	
	if current_pipe.shape == enums.pipe_shapes.STRAIGHT:
		if current_pipe.connected_pipe(pipe_direction) != null:
			direction = pipe_direction
	if direction == Vector2.ZERO: return
	var chosen_pipe = current_pipe.connected_pipe(direction)
	if chosen_pipe != null:
		pipe_direction = direction
		current_pipe = chosen_pipe
		arrived_from_pipe = true
	elif direction == current_pipe.exit_direction():
		start_exit()

func pressed_direction() -> Vector2:
	if Input.is_action_just_pressed("move_up"): return Vector2.UP
	if Input.is_action_just_pressed("move_down"): return Vector2.DOWN
	if Input.is_action_just_pressed("move_left"): return Vector2.LEFT
	if Input.is_action_just_pressed("move_right"): return Vector2.RIGHT
	return Vector2.ZERO
	
func start_exit() -> bool:
	if not current_pipe.exit_clear(Player): return false
	var motion = current_pipe.exit_direction() * exit_distance
	
	if Player.test_move(Player.global_transform, motion): return false
	exit_target = current_pipe.global_position + motion
	leaving_pipe = true
	return true
	
func update_animation(direction: float) -> void:
	if direction != 0:
		Player.player_anim.flip_h = direction < 0
