class_name PSMove
extends PlayerState

func _init(player:PlayerController):
	Player = player

func Enter():
	Player.player_anim.play("Idle")
	Player.velo.y = 0

func Exit():
	Player.finish_attack()

func Update(delta:float):
	if not Player.is_on_floor():
		Player.MyStateMachine.ChangeState(Player.MyStateMachine.Fall)
		return
	update_animation(Player.direction_x)
	if Player.direction_x:
		Player.velo.x = move_toward(Player.velo.x, Player.direction_x * Player.speed, Player.acceleration * delta)
	else:
		Player.velo.x = move_toward(Player.velo.x, 0, Player.friction * delta)
		

func Attack():
	start_attack()

func Jump():
	Player.velo.y += Player.jump_velocity


func update_animation(direction: float) -> void:
	if Player.is_attacking:
		return
	if direction != 0:
		Player.player_anim.flip_h = direction > 0 #built in flip horizontal and vertical (v)
		Player.attack_collision.position.x = direction * Player.attack_offset
	if direction != 0: #elif if inbetween if and else > serves as "otherwise if"
		Player.player_anim.play("Walk")
	else:
		Player.player_anim.play("Idle")


func start_attack():
	Player.is_attacking = true
	Player.player_anim.play("Attack")
	Player.attack_hit_box.set_deferred("disabled", false)
