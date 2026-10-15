extends EnemyState
class_name NullState

@export var current_state_ID : String = "currentstate"
@export var swap_to : enums.enemy_states

func Update(enemy : Enemy, info : Dictionary) -> Dictionary:
	info[current_state_ID] = swap_to
	return info

func Start(enemy : Enemy, info : Dictionary) -> Dictionary:
	print("error, something went wrong with an enemy and this state was swapped to")
	return info

func Exit(enemy : Enemy, info : Dictionary) -> Dictionary:
	return info
