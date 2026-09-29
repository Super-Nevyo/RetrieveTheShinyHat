extends Area2D
class_name Liquid

var Body : PlayerController


func _on_body_entered(body: Node2D) -> void:
	if body is PlayerController:
		Body = body
		body.change_water(true)


func _on_body_exited(body: Node2D) -> void:
	if body is PlayerController:
		Body = null
		body.change_water(false)
