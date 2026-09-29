extends Control
class_name InventoryUI

@export var item_icon: Array[TextureRect]

func ChangeInventoryUI(index: int, tex: Texture2D) -> void:
	if index > 4 or index < 0:
		return
	item_icon[index].texture = tex

func HoverInventoryUI(index: int) -> void:
	pass
