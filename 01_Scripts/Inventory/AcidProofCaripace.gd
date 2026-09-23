extends Item

func Enter(Player: PlayerController):
	Player.DmgLayer -= 4
	pass

func Exit(Player: PlayerController):
	Player.DmgLayer += 4
	pass
