extends Control
class_name InventoryUI

@export var item_icon: Array[TextureRect]
@onready var selector : TextureRect = $Control/ItemSelector

@export var item_frame: Array[TextureRect]
@export var hover_frame: Texture2D


func ChangeInventoryUI(index: int, tex: Texture2D) -> void:
	if index > 4 or index < 0:
		return
	item_icon[index].texture = tex

func HoverInventoryUI(index: int) -> void:
	if index < 0 || index >= item_icon.size():
		selector.visible = false
	else:
		var frame: TextureRect = item_frame[index]
		selector.texture = hover_frame
		selector.size = frame.size
		selector.global_position = frame.global_position
		#selector.position = item_icon[index].position + Vector2(item_icon[index].custom_minimum_size.x, 0)
		selector.visible = true
