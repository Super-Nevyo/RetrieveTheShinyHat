extends Node2D
class_name MetaActivator

@export var activation_amount : int = 1
@export var puzzle_id : String
@export var puzzle_type : RoomPersistances.meta_puzzles
var switch_flipped = false

func ActivatePuzzle() -> void:
	switch_flipped = !switch_flipped

func ChangeMeta() -> void:
	ActivatePuzzle()
	PuzzleSignalTransmiter.activate_meta.emit(puzzle_type,activation_amount * (-1 if switch_flipped else 1))
