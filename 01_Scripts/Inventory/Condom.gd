extends Item
class_name Condom

func Enter(Player: PlayerController):
	Player.blocks_enemy_dmg = true

func Exit(Player: PlayerController):
	Player.blocks_enemy_dmg = false

func Pickup() -> Item:
	return self
