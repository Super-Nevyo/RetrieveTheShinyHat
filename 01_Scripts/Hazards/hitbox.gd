extends Area2D

@export var damage_layer : int = 1
@export var damage : float = 10

func _physics_process(delta: float) -> void:
	for body in self.get_overlapping_bodies():
		if body.has_method("take_damage"):
			body.take_damage(damage_layer, damage)
