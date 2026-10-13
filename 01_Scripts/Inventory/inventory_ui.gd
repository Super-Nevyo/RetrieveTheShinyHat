extends Control
class_name InventoryUI

@export var item_icon: Array[TextureRect]
@onready var selector : TextureRect = $Control/ItemSelector

func ChangeInventoryUI(index: int, tex: Texture2D) -> void:
	if index > 4 or index < 0:
		return
	item_icon[index].texture = tex

func HoverInventoryUI(index: int) -> void:
	if index < 0 || index >= item_icon.size():
		selector.visible = false
	else:
		selector.visible = true
		selector.position = item_icon[index].position + Vector2(item_icon[index].custom_minimum_size.x, 0)
