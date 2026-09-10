extends "res://01_Scripts/WorldInteractions/AttackReceiver.gd"

func receive_attack():
	get_parent().UseSwitch()
