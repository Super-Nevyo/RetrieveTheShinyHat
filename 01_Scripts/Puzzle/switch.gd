extends "res://01_Scripts/Puzzle/PuzzleActivator.gd"
class_name Switch

@onready var anim : AnimationPlayer = $LeverAnimation
@export var cooldown : float = 0.5
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
