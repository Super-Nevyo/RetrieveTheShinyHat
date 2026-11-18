extends EnemyState
class_name EnemySpeakState
@export var speaking_frames : int
@export var speaking_frame_reference : String = "CurrentSpeakingFrame"
@export var state_machine_state : enums.enemy_states
@export var state_machine_current_reference : String = "SpeakingStateRef"
@export var words_reference : String = "Words"
@export var default_text : String = "Statement has not been set!"
@export var requires_translator : bool = true
@export var text_is_global : bool = false
@export var text_position : Vector2 = Vector2(100,-100)
@export var box_reference := "this box"

@export var wiggle_amplitude : float = 0.2
@export var wiggle_period : float = 0.5

func update(enemy : Enemy, info : Dictionary):
	#make creature wiggle up and down, count how long the sentance lasts for
	info[speaking_frame_reference] -= 1
	if info[speaking_frame_reference] <= 0:
		info[state_machine_current_reference] = state_machine_state
		return
	enemy.get_child(1).scale.y = wiggle_amplitude * cos(wiggle_period * info[speaking_frame_reference]) + 1
	pass

func start(enemy : Enemy, info : Dictionary):
	#make speach bubble, decide what is being said, trigger noise
	if !info.has(words_reference):
		info[words_reference] = default_text
	info[speaking_frame_reference] = speaking_frames
	var panel := PanelContainer.new()
	panel.name = "speach_panel"
	var margin := MarginContainer.new()
	margin.name = "speach_panel_margin"
	margin.add_theme_constant_override("margin_left", 10)
	margin.add_theme_constant_override("margin_top", 10)
	margin.add_theme_constant_override("margin_right", 10)
	margin.add_theme_constant_override("margin_bottom", 10)
	var text := Label.new()
	text.name = "speach_text"
	text.text = info[words_reference]
	margin.add_child(text)
	panel.add_child(margin)
	panel.position = text_position
	info[box_reference] = panel
	if !text_is_global:
		enemy.add_child(panel)
	else:
		enemy.get_parent().add_child(panel)
	

func exit(enemy : Enemy, info : Dictionary):
	#destroy speach bubble make sure scale of wiggle = 1
	info[box_reference].queue_free()
	enemy.get_child(1).scale.y = 1
	return 
