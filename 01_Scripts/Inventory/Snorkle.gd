extends Item
class_name Snorkle
@export var breath_multiplier : float = 4

func Enter(Player: PlayerController):
	Player.breath_decay = Player.breath_decay / breath_multiplier

func Exit(Player: PlayerController):
	Player.breath_decay = Player.breath_decay * breath_multiplier

func Pickup() -> Item:
	return self
