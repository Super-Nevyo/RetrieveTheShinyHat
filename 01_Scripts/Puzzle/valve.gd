extends "res://01_Scripts/Puzzle/switch.gd"

func ActivatePuzzle() -> void:
	switch_flipped = not switch_flipped
	
	for id in attached_ids:
		PuzzleSignalTransmiter.activate_puzzle.emit(id, 1.0)
