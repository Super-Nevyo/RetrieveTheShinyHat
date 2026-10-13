class_name PSGodMode
extends PlayerState

var player_collision_mask: int

func _init(player:PlayerController):
	Player = player

func Enter():
	player_collision_mask = Player.collision_mask
	Player.collision_mask = 0
	Player.velo = Vector2.ZERO
	Player.player_anim.play("Swimming")

func Exit():
	Player.collision_mask = player_collision_mask
	Player.velo = Vector2.ZERO

func Update(delta:float):
	var direction = Vector2(Player.direction_x, Player.direction_y).normalized()
	Player.velo = direction * Player.god_speed
	

func Attack():
	pass

func Jump():
	pass
