extends Area2D
class_name Liquid

var Body : PlayerController
@export var surface: Marker2D

func _on_body_entered(body: Node2D) -> void:
	if body is FloatingPlatform:
		body.liquid = self
		
	if body.has_method("change_water"):
		body.change_water(true)
	if body is PlayerController:
		Body = body


func _on_body_exited(body: Node2D) -> void:
	if body is FloatingPlatform:
		if body.liquid == self:
			body.liquid = null
	
	if body is PlayerController:
		Body = null
	if body.has_method("change_water"):
		body.change_water(false)
