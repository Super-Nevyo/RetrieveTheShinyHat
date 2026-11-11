@tool

extends puzzle_activated
class_name PipePiece

const art_sheet = preload("res://03_Art/Environment/unique.png")
const tile_size = 48
const ELBOW = Rect2(48, 144, tile_size, tile_size)
const STRAIGHT = Rect2(96, 144, tile_size, tile_size)
const T_SHAPE = Rect2(144, 144, tile_size, tile_size)

@export var shape: enums.pipe_shapes:
	set(value):
		shape = value
		if is_node_ready():
			update_art()
@export var mouth_side: enums.pipe_side
@onready var pipe_art: Sprite2D = $pipe_art

func _ready() -> void:
	update_art()
	
func _enter_tree() -> void:
	if not Engine.is_editor_hint():
		super._enter_tree()
	
func _exit_tree() -> void:
	if not Engine.is_editor_hint():
		super._exit_tree()
		
func activate_puzzle(id: int, amount: float) -> void:
	if id == signal_id:
		rotation_degrees = wrapf(rotation_degrees + 90.0 * amount, 0.0, 360.0)
		
#the pipes need to know of an opening and what direction it is at from the enums

func has_mouth(direction: Vector2) -> bool:
	var local_direction = direction.rotated(-global_rotation).round()
	match shape: #from enums (if adding, add to enums as well)
		enums.pipe_shapes.STRAIGHT:
			return local_direction in [Vector2.LEFT, Vector2.RIGHT]
		enums.pipe_shapes.ELBOW:
			return local_direction in [Vector2.RIGHT, Vector2.DOWN]
		enums.pipe_shapes.T_SHAPE:
			return local_direction in [Vector2.RIGHT, Vector2.LEFT, Vector2.DOWN]
	return false
	
func connects_pipe(other: PipePiece) -> bool: 
	var offset = other.global_position - global_position
	for direction in [Vector2.RIGHT, Vector2.LEFT, Vector2.UP, Vector2.DOWN]:
		if offset.is_equal_approx(direction * tile_size):
			return has_mouth(direction) and other.has_mouth(-direction)
	return false
	
func update_art() -> void:
	pipe_art.texture = art_sheet
	pipe_art.region_enabled = true
	
	match shape: 
		enums.pipe_shapes.STRAIGHT:
			pipe_art.region_rect = STRAIGHT
		enums.pipe_shapes.ELBOW:
			pipe_art.region_rect = ELBOW
		enums.pipe_shapes.T_SHAPE:
			pipe_art.region_rect = T_SHAPE
