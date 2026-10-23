extends "res://01_Scripts/Puzzle/PuzzleActivator.gd"

@onready var anim : AnimationPlayer = $LeverAnimation
@export var cooldown : float = 1.0
var can_activate : bool = true

func UseSwitch():
	if !can_activate:
		return
	can_activate = false
	
	if switch_flipped:
		anim.play("lever")
	else:
		anim.play_backwards("lever")
	ActivatePuzzle()
	$PlayerSfx.play()
	
	await get_tree().create_timer(cooldown).timeout
	can_activate = true
