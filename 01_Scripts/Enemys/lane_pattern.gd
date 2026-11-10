extends Resource
class_name LanePattern

@export var enabled: bool = true
@export_range(1, 600) var move_speed: float = 144
@export var slots: Array[bool] = [true,false]

#checks if enemy should enter the lane now
func spawn_now(slot_index: int) -> bool:
	if slots.is_empty():
		return false
	
	return slots[slot_index % slots.size()]
