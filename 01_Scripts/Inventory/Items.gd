class_name Item
extends Resource

@export var tex : Texture2D

func Enter(Player: PlayerController):
	pass

func Exit(Player: PlayerController):
	pass

func Pickup() -> Item:
	return self
