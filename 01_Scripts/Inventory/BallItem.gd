extends Item
class_name BallItem

func Enter(Player: PlayerController):
	Player.has_ball = true

func Exit(Player: PlayerController):
	Player.has_ball = false
