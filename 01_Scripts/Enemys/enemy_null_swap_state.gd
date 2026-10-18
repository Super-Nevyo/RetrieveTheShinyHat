extends EnemyState
class_name NullState

@export var current_state_ID : String = "currentstate"
@export var swap_to : enums.enemy_states

func Update(enemy : Enemy, info : Dictionary):
	info[current_state_ID] = swap_to
	return 

func Start(enemy : Enemy, info : Dictionary):
	print("error, something went wrong with an enemy and this state was swapped to")
	return 

func Exit(enemy : Enemy, info : Dictionary):
	return 
