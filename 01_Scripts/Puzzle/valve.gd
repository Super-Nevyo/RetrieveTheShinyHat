extends "res://01_Scripts/Puzzle/switch.gd"
class_name Valve

var turns: int = 0

func ActivatePuzzle() -> void:
	turns = (turns + 1) % 4
	switch_flipped = not switch_flipped
	for id in attached_ids:
		PuzzleSignalTransmiter.activate_puzzle.emit(id, 1.0)

func play_animation() -> void:
	$ValveAnim.stop()
	$ValveAnim.play("valve_turn")
