@tool #this makes this script a tool - here we go
extends puzzle_activated
class_name PipePiece

# constants - so the tool can always call them in
const art_sheet = preload("res://03_Art/Environment/unique.png")
const tile_size = 48
const ELBOW = Rect2(48, 144, tile_size, tile_size)
const STRAIGHT = Rect2(96, 144, tile_size, tile_size)
const T_SHAPE = Rect2(144, 144, tile_size, tile_size)
# from enums finds directions for each pipe
const DIRECTIONS = {
	enums.pipe_side.UP: Vector2.UP,
	enums.pipe_side.RIGHT: Vector2.RIGHT,
	enums.pipe_side.DOWN: Vector2.DOWN,
	enums.pipe_side.LEFT: Vector2.LEFT,}
@export var shape: enums.pipe_shapes:
	set(value):
		shape = value
		if is_node_ready():
			if exit_side != enums.pipe_side.NONE:
				if not has_opening(DIRECTIONS[exit_side]):
					exit_side = enums.pipe_side.NONE
			update_art()
@export var exit_side: enums.pipe_side
@onready var pipe_art = get_node_or_null ("pipe_art") as Sprite2D

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

func has_opening_exit(direction: Vector2) -> bool:
	var local_direction = direction.rotated(-global_rotation).round()
	return has_opening(local_direction)
	
func has_opening(direction: Vector2) -> bool:
	match shape: #from enums (if adding, add to enums as well)
		enums.pipe_shapes.STRAIGHT:
			return direction in [Vector2.LEFT, Vector2.RIGHT]
		enums.pipe_shapes.ELBOW:
			return direction in [Vector2.RIGHT, Vector2.DOWN]
		enums.pipe_shapes.T_SHAPE:
			return direction in [Vector2.RIGHT, Vector2.LEFT, Vector2.DOWN]
	return false
	
func connects_pipe(other: PipePiece) -> bool: 
	var offset = other.global_position - global_position
	for direction in [Vector2.RIGHT, Vector2.LEFT, Vector2.UP, Vector2.DOWN]:
		if offset.is_equal_approx(direction * tile_size):
			return has_opening_exit(direction) and other.has_opening_exit(-direction)
	return false
	
func update_art() -> void:
	pipe_art = get_node_or_null("pipe_art") as Sprite2D
	if pipe_art == null:
		return
		
	pipe_art.texture = art_sheet
	pipe_art.region_enabled = true
	
	match shape: 
		enums.pipe_shapes.STRAIGHT:
			pipe_art.region_rect = STRAIGHT
		enums.pipe_shapes.ELBOW:
			pipe_art.region_rect = ELBOW
		enums.pipe_shapes.T_SHAPE:
			pipe_art.region_rect = T_SHAPE

#validate property: Godot calls this when prepping the inspector for fields. 
#Pipes have shapes and certain shapes have exits but others dont
#Which dropdowns should be shown for mouth per pipe piece shape?

func _validate_property(property: Dictionary) -> void:
	if property.name != &"exit_side":
		return
	var options := PackedStringArray(["None:0"])
	for side in DIRECTIONS:
		if has_opening(DIRECTIONS[side]):
			var label := str(enums.pipe_side.find_key(side)).capitalize()
			options.append("%s:%d" % [label, side])
	property.hint = PROPERTY_HINT_ENUM
	property.hint_string = ",".join(options)
	
