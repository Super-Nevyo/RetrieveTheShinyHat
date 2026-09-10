extends "res://01_Scripts/Puzzle/PuzzleActivator.gd"

var ElementsOnPlate: int = 0


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("triggers_pressure_plates"):
		ElementsOnPlate += 1
		if ElementsOnPlate == 1:
			ActivatePuzzle()
	
	pass # Replace with function body.



func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.has_method("triggers_pressure_plates"):
		ElementsOnPlate -= 1
		if ElementsOnPlate == 0:
			ActivatePuzzle()
	pass # Replace with function body.
