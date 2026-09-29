extends Liquid

func _physics_process(delta: float) -> void:
	#for body in Body:
	if Body is PlayerController:
		Body.take_damage(4,0.005)
	pass
