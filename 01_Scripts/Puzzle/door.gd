extends Node2D

@export var DoorStartPosition:float = -50
@export var DoorMovePosition:float = 50
@export var ActivationAmount:float = 0
@export var Door: Node2D

func ActivatePuzzle(Amount: float):
	ActivationAmount += Amount
	if ActivationAmount >= 1:
		ChangeDoorState(true)
	else:
		ChangeDoorState(false)
	pass


func ChangeDoorState(Open:bool):
	if Open:
		Door.position = Vector2(0,DoorMovePosition)
	else:
		Door.position = Vector2(0,DoorStartPosition)
	pass
