extends Node2D
class_name LiquidSignal

@export var detector: LiquidDetector
@export var underwater: enums.enemy_states = enums.enemy_states.IDLE
@export var drowned: enums.enemy_states = enums.enemy_states.DROWNED
@onready var enemy : Enemy = get_parent()

func _ready() -> void:
	detector.liquid_entered.connect(on_liquid_changed)
	detector.liquid_exited.connect(on_liquid_changed)
	call_deferred("on_liquid_changed")

func on_liquid_changed() -> void:
	var is_underwater = false
	for area in detector.get_overlapping_areas():
		if area is Liquid:
			is_underwater = true
			break
	
	var next_state = underwater if is_underwater else drowned
	var machine = enemy.MyStateMachine
	var info = enemy.MyInfo
	var id = machine.current_state_ID
	var previous_state = info.get(id, enums.enemy_states.NULL)
	
	if previous_state == next_state:
		return
		
	if machine.States.has(previous_state):
		machine.States[previous_state].exit(enemy, info)
	
	info[id] = next_state
	machine.States[next_state].start(enemy, info)
