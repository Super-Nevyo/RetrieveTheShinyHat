class_name PSInPipe
extends PlayerState

var current_pipe: PipePiece
var pipe_direction: Vector2
var pipe_speed: float = 200
var sprite_pipe: Vector2

func _init(player:PlayerController):
	Player = player

func Enter():
	Player.finish_attack()
	Player.velo = Vector2.ZERO
	Player.velocity = Vector2.ZERO
	
	sprite_pipe = Player.player_anim.position
	Player.player_anim.position = Player.get_node("PlayerHitBox").position
	Player.player_anim.play("InPipe")
	
	var exit_direction: Vector2 = PipePiece.DIRECTIONS[current_pipe.exit_side]
	pipe_direction = -exit_direction.rotated(current_pipe.global_rotation).round()

func Exit():
	Player.player_anim.position = sprite_pipe
	current_pipe = null

func Update(delta:float):
	var hitbox: CollisionShape2D = Player.get_node("PlayerHitBox")
	var center = hitbox.global_position
	var target = current_pipe.global_position
	var next_center = center.move_toward(target,pipe_speed * delta)
	Player.global_position += next_center - center
	if next_center.is_equal_approx(target):
		get_in_pipe()

func get_in_pipe() -> void:
	if current_pipe.shape == enums.pipe_shapes.STRAIGHT:
		var forward_pipe = current_pipe.connected_pipe(pipe_direction)
		if forward_pipe != null:
			current_pipe = forward_pipe
			return
	var direction := pressed_direction()
	
	if direction == Vector2.ZERO:
		return
	var chosen_pipe = current_pipe.connected_pipe(direction)
	
	if chosen_pipe != null:
		pipe_direction = direction
		current_pipe = chosen_pipe

func pressed_direction() -> Vector2:
	if Input.is_action_just_pressed("move_up"): return Vector2.UP
	if Input.is_action_just_pressed("move_down"): return Vector2.DOWN
	if Input.is_action_just_pressed("move_left"): return Vector2.LEFT
	if Input.is_action_just_pressed("move_right"): return Vector2.RIGHT
	return Vector2.ZERO
	
func update_animation(direction: float) -> void:
	if direction != 0:
		Player.player_anim.flip_h = direction < 0
