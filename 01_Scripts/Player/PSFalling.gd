class_name PSFalling
extends PlayerState

func _init(player:PlayerController):
	Player = player

func Enter():
	Player.player_anim.play("Jump")

func Exit():
	pass

func Update(delta:float):
	if Player.is_on_floor():
		Player.MyStateMachine.ChangeState(Player.MyStateMachine.Move)
		return
	Player.velo.y += get_custom_gravity() * delta
	Player.player_anim.play("Jump")
	if Player.direction_x:
		Player.velo.x = move_toward(Player.velo.x, Player.direction_x * Player.speed, Player.acceleration * delta)
	else:
		Player.velo.x = move_toward(Player.velo.x, 0, Player.friction * delta)

func Attack():
	pass

func Jump():
	pass

func get_custom_gravity():
	if Player.velo.y < 0.0:
		return Player.jump_gravity
	else:
		return Player.fall_gravity
