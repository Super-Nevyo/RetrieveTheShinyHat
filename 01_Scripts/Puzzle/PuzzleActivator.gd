extends Node2D

@export var AttachedNodes:Array[Node2D]
@export var ActivationAmount:Array[float]
var SwitchFlipped: bool = false


func ActivatePuzzle():
	SwitchFlipped = !SwitchFlipped
	if AttachedNodes.size() == ActivationAmount.size():
		for i in range(AttachedNodes.size()):
			if AttachedNodes[i].has_method("ActivatePuzzle"):
				AttachedNodes[i].ActivatePuzzle(ActivationAmount[i] * 1.0 if SwitchFlipped else -1.0)
	else:
		for i in range(AttachedNodes.size()):
			if AttachedNodes[i].has_method("ActivatePuzzle"):
				AttachedNodes[i].ActivatePuzzle(ActivationAmount[0] * 1.0 if SwitchFlipped else -1.0)
