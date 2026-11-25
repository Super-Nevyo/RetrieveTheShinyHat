extends EnemyState
class_name EnemyConsideringState
@export var next_state_machine_state : enums.enemy_states
@export var state_machine_current_reference : String = "SpeakingStateRef"
@export var string_reference : String = "Words"
@export var current_array_index_reference : String = "CurrentArrayIndex"
@export var strings_to_cycle_through : Array[String]

func update(enemy : Enemy, info : Dictionary):
	info[state_machine_current_reference] = next_state_machine_state

func start(enemy : Enemy, info : Dictionary):
	if !info.has(current_array_index_reference):
		info[current_array_index_reference] = 0
	else:
		info[current_array_index_reference] += 1
	
	if info[current_array_index_reference] >= strings_to_cycle_through.size() :
		info[current_array_index_reference] = 0
	info[string_reference] = strings_to_cycle_through[info[current_array_index_reference]]

func exit(enemy : Enemy, info : Dictionary):
	return 
