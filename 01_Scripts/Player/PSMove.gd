class_name PSMove
extends PlayerState

var recent_direction : float = 0
var held_box : Box

func _init(player:PlayerController):
	Player = player

func Enter():
	Player.player_anim.play("Idle")
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
	if Player.direction_x:
		Player.velo.x = move_toward(Player.velo.x, Player.direction_x * Player.speed, Player.acceleration * delta)
		recent_direction = Player.direction_x
	else:
		Player.velo.x = move_toward(Player.velo.x, 0, Player.friction * delta)
		

func Attack():
	if held_box != null:
		held_box.throw(Vector2(-1 if Player.player_anim.flip_h else 1,-1).normalized(), Player.throw_speed)
		held_box = null
	else:
		start_attack()

func Jump():
	Player.velo.y += Player.jump_velocity


func update_animation(direction: float) -> void:
	if Player.is_attacking:
		return
	if direction != 0:
		Player.player_anim.flip_h = direction < 0 #built in flip horizontal and vertical (v)
		Player.attack_collision.position.x = direction * Player.attack_offset
	if direction != 0: #elif if inbetween if and else > serves as "otherwise if"
		Player.player_anim.play("Walk")
	else:
		Player.player_anim.play("Idle")


func start_attack():
	Player.player_anim.offset.x = 24 * (-1 if Player.player_anim.flip_h else 1)
	Player.is_attacking = true
	Player.player_anim.play("Attack")
	Player.attack_hit_box.set_deferred("disabled", false)

func successful_attack(other: AttackReceiver) -> void:
	if other.get_parent() is Box:
		held_box = other.get_parent()
