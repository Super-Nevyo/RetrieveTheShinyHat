class_name PSSwim
extends PlayerState



func _init(player:PlayerController):
	Player = player

func Enter():
	Player.player_anim.play("Swimming")

func Exit():
	Player.current_breath = Player.max_breath
	Player.BreathChanged.emit(Player.current_breath)

func Update(delta:float):
	Player.current_breath -= Player.breath_decay * delta
	Player.BreathChanged.emit(Player.current_breath)
	if Player.current_breath <= 0:
		Player.take_damage(1,Player.drown_dmg)
		Player.current_breath += Player.breath_decay * Player.drown_relief
	if Player.direction_x != 0:
		Player.player_anim.flip_h = Player.direction_x < 0
	if Player.direction_x:
		Player.velo.x = move_toward(Player.velo.x, Player.direction_x * Player.swim_speed, Player.swim_acceleration * delta)
	else:
		Player.velo.x = move_toward(Player.velo.x, 0, Player.swim_friction * delta)
	if Player.direction_y:
		Player.velo.y = move_toward(Player.velo.y, Player.direction_y * Player.swim_speed, Player.swim_acceleration * delta)
	else:
		Player.velo.y = move_toward(Player.velo.y, 0, Player.swim_friction * delta)

func Attack():
	pass

func Jump():
	pass
