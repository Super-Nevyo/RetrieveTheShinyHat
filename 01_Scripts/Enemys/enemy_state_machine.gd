extends Resource
class_name EnemyStateMachine

@export var current_state_ID : String = "currentstate"
@export var States : Dictionary[enums.enemy_states,EnemyState]

func update(enemy : Enemy, info : Dictionary) -> Dictionary:
	if !info.has(current_state_ID):
		info[current_state_ID] = enums.enemy_states.NULL
	var temp_dic = (States[info[current_state_ID]].Update(enemy,info))
	if temp_dic[current_state_ID] == info[current_state_ID]:
		return temp_dic
	info[current_state_ID].Exit(enemy,info)
	temp_dic[current_state_ID].Start(enemy,info)
	return temp_dic
