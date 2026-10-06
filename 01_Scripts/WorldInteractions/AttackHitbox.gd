extends Area2D

signal attack_successful(AttackReveiver)

func _on_area_entered(area: Area2D) -> void:
	if area is AttackReceiver:
		attack_successful.emit(area)
		area.receive_attack()
