extends Node2D

@export var itemInfo : Item

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is PlayerController:
		body.add_item(itemInfo,1)
