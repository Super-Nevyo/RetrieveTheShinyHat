@abstract extends Node2D
class_name MetaActivated

var activation_amount : int = 0
var concluded : bool = true
@export var puzzle_type : enums.meta_puzzle_names

func activate_puzzle(new:int) -> void:
	activation_amount = new
	concluded = false

func set_puzzle(new:int) -> void:
	activation_amount = new
	concluded = true
