extends EnemyState
class_name BoxStateChangeState

@export var state_machine_state : enums.enemy_states
@export var state_machine_current_reference : String = "currentstate"
@export var is_facing_right_id : String = "isfacingright"
@export var box_id : String = "mybox"

# box casting 
@export var is_global := false
@export var is_leftright_dependant := true
@export var box_size := Vector2(100,100)
@export var box_position := Vector2(0,0)
@export var mask := 2

func update(enemy : Enemy, info : Dictionary):
	if !is_global && is_leftright_dependant:
		info[box_id].position.x = box_position.x if info[is_facing_right_id] else -box_position.x
	if info[box_id].has_overlapping_bodies():
		info[state_machine_current_reference] = state_machine_state
	return

func start(enemy : Enemy, info : Dictionary):
	if !info.has(box_id):
		var temp_box := Area2D.new()
		var temp_collider := CollisionShape2D.new()
		temp_collider.shape = RectangleShape2D.new()
		temp_collider.shape.size = box_size
		temp_box.add_child(temp_collider)
		temp_box.collision_mask = mask
		temp_box.collision_layer = 0
		if is_global:
			enemy.get_parent().add_child(temp_box)
		else:
			enemy.add_child(temp_box)
		temp_box.position = box_position
		info[box_id] = temp_box
	if !info.has(is_facing_right_id):
		info[is_facing_right_id] = false

func exit(enemy : Enemy, info : Dictionary):
	return 
