extends Node2D

@export var AttachedNodes:Array[Node2D]
@export var ActivationAmount:Array[float]
var SwitchFlipped: bool = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	#once the unique identier is set, make an if statement
		UseSwitch()


func UseSwitch():
	SwitchFlipped = !SwitchFlipped
	if AttachedNodes.size() == ActivationAmount.size():
		for i in range(AttachedNodes.size()):
			if AttachedNodes[i].has_method("ActivatePuzzle"):
				AttachedNodes[i].ActivatePuzzle(ActivationAmount[i] * 1 if SwitchFlipped else -1)
	else:
		for i in range(AttachedNodes.size()):
			if AttachedNodes[i].has_method("ActivatePuzzle"):
				AttachedNodes[i].ActivatePuzzle(ActivationAmount[0] * 1 if SwitchFlipped else -1)
