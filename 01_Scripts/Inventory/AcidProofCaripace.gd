extends Item
class_name AcidProofCarapace

func Enter(Player: PlayerController):
	Player.DmgLayer -= 4
	Player.umbrella.show()
	pass

func Exit(Player: PlayerController):
	Player.DmgLayer += 4
	Player.umbrella.hide()
	pass
