class_name PSSwim
extends PlayerState



func _init(player:PlayerController):
	Player = player

func Enter():
	pass

func Exit():
	pass

func Update(delta:float):
	if Player.direction_x :
		Player.velo.x = move_toward(Player.velo.x, Player.direction_x * Player.speed, Player.acceleration * delta)
	else:
		Player.velo.x = move_toward(Player.velo.x, 0, Player.friction * delta)
	if Player.direction_y:
		Player.velo.y = move_toward(Player.velo.y, Player.direction_y * Player.speed, Player.acceleration * delta)
	else:
		Player.velo.y = move_toward(Player.velo.y, 0, Player.friction * delta)

func Attack():
	pass

func Jump():
	pass
