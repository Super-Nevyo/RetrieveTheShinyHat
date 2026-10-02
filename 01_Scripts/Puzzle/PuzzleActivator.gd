extends Node2D
class_name PuzzleActivator

@export var attached_ids:Array[int]
@export var activation_amount:Array[float]

@export var puzzle_id: String
var switch_flipped: bool = false



func ActivatePuzzle():
	switch_flipped = !switch_flipped
	if attached_ids.size() == activation_amount.size():
		for i in range(attached_ids.size()):
			PuzzleSignalTransmiter.activate_puzzle.emit(attached_ids[i], activation_amount[i] * (1.0 if switch_flipped else -1.0))
	else:
		for i in range(attached_ids.size()):
			PuzzleSignalTransmiter.activate_puzzle.emit(attached_ids[i], activation_amount[0] * (1.0 if switch_flipped else -1.0))
