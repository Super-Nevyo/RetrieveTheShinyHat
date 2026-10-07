extends "res://01_Scripts/Puzzle/PuzzleActivator.gd"

@onready var anim : AnimationPlayer = $LeverAnimation

func UseSwitch():
	if switch_flipped:
		anim.play("lever")
	else:
		anim.play_backwards("lever")
	ActivatePuzzle()
