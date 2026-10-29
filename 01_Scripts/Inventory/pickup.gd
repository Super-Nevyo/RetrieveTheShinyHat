extends Node2D
class_name PickupItem

@export var itemInfo : Item
@export var item_disappears : bool = true

func get_item_info() -> Item:
	return itemInfo

func hide_item():
	if item_disappears:
		self.visible = false
		$Area2D/CollisionShape2D.disabled = true
