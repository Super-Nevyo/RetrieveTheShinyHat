class_name PSMove
extends PlayerState

var recent_direction : float = 0
var held_box : Box

func _init(player:PlayerController):
	Player = player

func Enter():
	Player.player_anim.play("Ball" if Player.has_ball else "Idle")
	Player.velo.y = 0
	Player.attack_collision.attack_successful.connect(successful_attack)

func Exit():
	Player.finish_attack()
	Player.attack_collision.attack_successful.disconnect(successful_attack)
	if held_box != null:
		held_box.throw(Vector2.ZERO, 0)
		held_box = null

func Update(delta:float):
	if not Player.is_on_floor():
		Player.MyStateMachine.ChangeState(Player.MyStateMachine.Fall)
		return
	update_animation(Player.direction_x)
	if held_box != null:
		held_box.accl_toward(Player.hold_position.global_position)
	
	if Player.has_ball and Player.is_attacking:
		Player.velo.x = 0
		return
	
	if Player.direction_x:
		if Player.has_ball:
			Player.velo.x = move_toward(Player.velo.x, Player.direction_x * Player.ball_speed, Player.ball_acceleration * delta)
		
		else:
			Player.velo.x = move_toward(Player.velo.x, Player.direction_x * Player.speed, Player.acceleration * delta)
		recent_direction = Player.direction_x
	else:
		if Player.has_ball:
			Player.velo.x = move_toward(Player.velo.x, 0, Player.friction * delta)
		Player.velo.x = move_toward(Player.velo.x, 0, Player.friction * delta)
		

func Attack():
	if held_box != null:
		held_box.throw(Vector2(-2 if Player.player_anim.flip_h else 2,-1).normalized(), Player.throw_speed)
		held_box = null
	else:
		start_attack()

func Jump():
	if Player.has_ball:
		if Player.is_attacking:
			return
			
		if Player.velocity.x >= Player.ball_jump_speed or Player.velocity.x <= -Player.ball_jump_speed:
			Player.velo.y = Player.ball_fast_jump
		else:
			Player.velo.y = Player.ball_small_jump
		
		Player.MyStateMachine.ChangeState(Player.MyStateMachine.Fall)
	else:
		Player.velo.y += Player.jump_velocity


func update_animation(direction: float) -> void:
	if Player.is_attacking:
		return
	if direction != 0:
		Player.player_anim.flip_h = direction < 0
		Player.attack_collision.position.x = direction * Player.attack_offset
	if Player.has_ball:
		Player.player_anim.play("Ball")
	elif direction != 0:
		Player.player_anim.play("Walk")
	else:
		Player.player_anim.play("Idle")


func start_attack():
	if Player.has_ball:
		Player.velo.x = 0
	Player.player_anim.offset.x = 24 * (-1 if Player.player_anim.flip_h else 1)
	Player.is_attacking = true
	Player.player_anim.play("Attack")
	Player.attack_hit_box.set_deferred("disabled", false)

func successful_attack(other: AttackReceiver) -> void:
	if other.get_parent() is Box:
		held_box = other.get_parent()
