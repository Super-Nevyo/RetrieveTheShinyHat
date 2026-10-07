@abstract extends Node2D
class_name MetaActivated

var activation_amount : int = 0
var concluded : bool = true
@export var puzzle_type : RoomPersistances.meta_puzzles

func activate_puzzle(id: RoomPersistances.meta_puzzles, new:int) -> void:
	if puzzle_type == id:
		activation_amount = new
		concluded = false

func set_puzzle(new:int) -> void:
	activation_amount = new
	concluded = true

func _enter_tree() -> void:
	PuzzleSignalTransmiter.activate_meta.connect(activate_puzzle)
	
func _exit_tree() -> void:
	PuzzleSignalTransmiter.activate_meta.disconnect(activate_puzzle)
