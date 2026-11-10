extends Node2D
class_name SpermLane

@export var rows: Array [LanePattern] = []
@export var enemy_scene: PackedScene

@onready var spawn_area: CollisionShape2D = $Area2D/CollisionShape2D
var slot_indices: Array[int] = []

func _ready() -> void:
	var row_count = mini(rows.size(), 8)
	slot_indices.resize(row_count)
	slot_indices.fill(0)
	for row_index in range(row_count):
		var row = rows[row_index]
		if row == null:
			continue
			
		var timer := Timer.new()
		add_child(timer)
		timer.timeout.connect(read_next_slot.bind(row_index))
		timer.start(144.0 / row.move_speed)
	
func _physics_process(delta: float) -> void:
	var rectangle = spawn_area.shape as RectangleShape2D
	var right_end = rectangle.size.x / 2
	
	for child in get_children():
		if child is Enemy:
			var center_x = spawn_area.to_local(child.global_position).x
			if center_x + 72 > right_end:
				child.queue_free()
				
func read_next_slot(row_index: int) -> void:
	var row = rows[row_index]
	var slot_index = slot_indices[row_index]
	
	if row.enabled and row.spawn_now(slot_index):
		spawn_enemy(row_index)
	
	slot_indices[row_index] += 1

func spawn_enemy(row_index: int) -> void:
	var rectangle = spawn_area.shape as RectangleShape2D
	var row_bottom = (row_index + 1) * 96
	
	if rectangle.size.x < 144 or row_bottom > rectangle.size.y:
		return
		
	var top_left = -rectangle.size / 2.0
	var row_center_y = row_index * 96 + 48
	var spawn_point = top_left + Vector2(72, row_center_y)
	
	var enemy = enemy_scene.instantiate() as Enemy
	enemy.position = to_local(spawn_area.to_global(spawn_point))
	add_child(enemy)
	enemy.MyInfo["lane_speed"] = rows[row_index].move_speed
