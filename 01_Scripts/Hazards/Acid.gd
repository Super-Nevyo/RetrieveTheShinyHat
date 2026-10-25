extends Liquid

@export var acid_tick_dmg : float = 0.005

func _physics_process(_delta: float) -> void:
	#for body in Body:
	if Body is PlayerController:
		Body.take_damage(4,acid_tick_dmg * _delta)
	pass
