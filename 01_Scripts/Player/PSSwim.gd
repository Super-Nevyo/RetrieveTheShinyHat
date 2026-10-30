class_name PSSwim
extends PlayerState



func _init(player:PlayerController):
	Player = player

func Enter():
	Player.velo.y = minf(Player.velo.y, Player.submerged_cap)
	Player.player_anim.play("Swimming")
	Player.liquid_counter.water_exited.connect(become_dry)

func Exit():
	Player.current_breath = Player.max_breath
	Player.BreathChanged.emit(Player.current_breath)
	Player.liquid_counter.water_exited.disconnect(become_dry)

func Update(delta:float):
	Player.current_breath -= Player.breath_decay * delta
	Player.BreathChanged.emit(Player.current_breath)
	if Player.current_breath <= 0:
		Player.take_damage(1,Player.drown_dmg)
		Player.current_breath += Player.breath_decay * Player.drown_relief
	if Player.input_handler.direction.x != 0:
		Player.player_anim.flip_h = Player.input_handler.direction.x < 0
	if Player.input_handler.direction.x:
		Player.velo.x = move_toward(Player.velo.x, Player.input_handler.direction.x * Player.swim_speed, Player.swim_acceleration * delta)
	else:
		Player.velo.x = move_toward(Player.velo.x, 0, Player.swim_friction * delta)
	if Player.input_handler.direction.y:
		Player.velo.y = move_toward(Player.velo.y, Player.input_handler.direction.y * Player.swim_speed, Player.swim_acceleration * delta)
	else:
		Player.velo.y = move_toward(Player.velo.y, 0, Player.submerged_cap * delta) #Player.swim_friction * delta

func Attack():
	pass

func Jump():
	pass

func become_dry():
	Player.MyStateMachine.ChangeState(Player.MyStateMachine.Fall)
