extends Resource
class_name EnemyStateMachine

@export var current_state_ID : String = "currentstate"
@export var States : Dictionary[enums.enemy_states,EnemyState]

func update(enemy : Enemy, info : Dictionary):
	if !info.has(current_state_ID):
		info[current_state_ID] = enums.enemy_states.NULL
	var temp_state = info[current_state_ID]
	States[info[current_state_ID]].update(enemy,info)
	if temp_state == info[current_state_ID]:
		return
	if !States.has(info[current_state_ID]):
		info[current_state_ID] = enums.enemy_states.NULL
	States[temp_state].exit(enemy,info)
	States[info[current_state_ID]].start(enemy,info)
	return
