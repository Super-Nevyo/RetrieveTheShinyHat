extends "res://01_Scripts/Puzzle/PuzzleActivator.gd"

var ElementsOnPlate: int = 0


func _on_area_2d_body_entered(body: Node2D) -> void:
	ElementsOnPlate += 1
	if ElementsOnPlate == 1:
		ActivatePuzzle()
	



func _on_area_2d_body_exited(body: Node2D) -> void:
	ElementsOnPlate -= 1
	if ElementsOnPlate == 0:
		ActivatePuzzle()
