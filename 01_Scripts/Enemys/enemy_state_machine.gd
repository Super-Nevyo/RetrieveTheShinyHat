extends Resource
class_name EnemyStateMachine

@export var current_state_ID : String = "currentstate"
@export var States : Dictionary[enums.enemy_states,EnemyState]

func update(enemy : Enemy, info : Dictionary):
	if !info.has(current_state_ID):
		info[current_state_ID] = enums.enemy_states.NULL
	var temp_state = info[current_state_ID]
	States[info[current_state_ID]].Update(enemy,info)
	if temp_state == info[current_state_ID]:
		return
	States[temp_state].Exit(enemy,info)
	States[info[current_state_ID]].Start(enemy,info)
	return
