extends Area2D

@export var num_item_slots : int = 4
@onready var player : PlayerController = $".."
var hover_item : Item
var hover_slot : int = 0

func _physics_process(delta: float) -> void:
	if hover_item != null:
		if Input.is_action_just_pressed("attack"):
			player.add_item(hover_item,hover_slot)
		if Input.is_action_just_pressed("move_down"):
			hover_slot = (((hover_slot - 1) % num_item_slots) + num_item_slots) % num_item_slots
			player.emit_signal("ItemHovered", hover_slot)
		if Input.is_action_just_pressed("move_up"):
			hover_slot = (hover_slot + 1) % num_item_slots
			player.emit_signal("ItemHovered", hover_slot)

func _on_area_entered(area: Area2D) -> void:
	var parent = area.get_parent()
	if parent is PickupItem:
		hover_item = parent.get_item_info()
		hover_slot = 0
		player.emit_signal("ItemHovered", hover_slot)


func _on_area_exited(area: Area2D) -> void:
	hover_item = null
	player.emit_signal("ItemHovered", -1)
