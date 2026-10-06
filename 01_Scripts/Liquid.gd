extends Area2D
class_name Liquid

var Body : PlayerController


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("change_water"):
		body.change_water(true)
	if body is PlayerController:
		Body = body


func _on_body_exited(body: Node2D) -> void:
	if body is PlayerController:
		Body = null
	if body.has_method("change_water"):
		body.change_water(false)
