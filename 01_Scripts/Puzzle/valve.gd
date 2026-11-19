extends "res://01_Scripts/Puzzle/switch.gd"
class_name Valve

var turns: int = 0

func ActivatePuzzle() -> void:
	turns = (turns + 1) % 4
	switch_flipped = not switch_flipped
	
	for i in range(attached_ids.size()):
		var amount = 1
		if i < activation_amount.size():
			amount = activation_amount[i]
			
		PuzzleSignalTransmiter.activate_puzzle.emit(attached_ids[i], amount)

func play_animation() -> void:
	$ValveAnim.stop()
	$ValveAnim.play("valve_turn")
