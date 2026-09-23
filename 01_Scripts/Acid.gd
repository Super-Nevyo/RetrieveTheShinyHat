extends Liquid

func _physics_process(delta: float) -> void:
	for body in Body:
		if body is PlayerController:
			body.take_damage(4,0.5)
	pass
