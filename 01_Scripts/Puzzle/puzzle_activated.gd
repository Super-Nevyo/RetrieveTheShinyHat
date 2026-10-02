@abstract extends Node2D
class_name puzzle_activated

@export var ActivationAmount:float = 0
@export var signal_id: int = 0

@abstract func activate_puzzle(id: int, Amount: float)

func _enter_tree() -> void:
	PuzzleSignalTransmiter.activate_puzzle.connect(activate_puzzle)
	
func _exit_tree() -> void:
	PuzzleSignalTransmiter.activate_puzzle.disconnect(activate_puzzle)
