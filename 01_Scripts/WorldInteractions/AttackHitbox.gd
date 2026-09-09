extends Area2D

func _on_area_entered(area: Area2D) -> void:
	if area is AttackReceiver:
		area.receive_attack()
