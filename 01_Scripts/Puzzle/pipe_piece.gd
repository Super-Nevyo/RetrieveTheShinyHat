@tool #this makes this script a tool - here we go
extends puzzle_activated
class_name PipePiece

# constants - so the tool can always call them in
const art_sheet = preload("res://03_Art/Environment/penisart.png")
const tile_size = 48
const DIRECTIONS = {
	enums.pipe_side.UP: Vector2.UP,
	enums.pipe_side.RIGHT: Vector2.RIGHT,
	enums.pipe_side.DOWN: Vector2.DOWN,
	enums.pipe_side.LEFT: Vector2.LEFT,}
const PIPES = {
	enums.pipe_shapes.STRAIGHT: {
		"Normal": Vector2i(480, 624),
		"Eyes": Vector2i(384, 624),
		"Normal Low": Vector2i(480, 672),
		"Eyes Low": Vector2i(384, 672),
		"Thin": Vector2i(528, 624),
		"Thin Eyes": Vector2i(432, 624),
		"Thin Low": Vector2i(528, 672),
		"Thin Low Eyes": Vector2i(432, 672),
	},
	enums.pipe_shapes.ELBOW: {
		"Eyes": Vector2i(336, 576),
		"Normal": Vector2i(576, 576),
	},
	enums.pipe_shapes.T_SHAPE: {
		"Plain": Vector2i(528, 576),
		"Normal": Vector2i(432, 576),
	},
	enums.pipe_shapes.CROSS: {
		"Plain": Vector2i(480, 576),
		"Normal": Vector2i(384, 576),
	},}
@export var shape: enums.pipe_shapes:
	set(value):
		shape = value
		if is_node_ready():
			pipe_variant = 0
			if exit_side != enums.pipe_side.NONE:
				if not has_opening(DIRECTIONS[exit_side]):
					exit_side = enums.pipe_side.NONE
			notify_property_list_changed()
@export var pipe_variant : int = 0:
	set(value):
		var pieces: Dictionary = PIPES[shape]
		pipe_variant = posmod(value, pieces.size()) #posmod to wrap in both directions so it circles
		if is_node_ready():
			update_art()
@export var exit_side: enums.pipe_side:
	set (value):
		exit_side = value
		if is_node_ready():
			update_exit_area()
@onready var pipe_art = get_node_or_null ("pipe_art") as Sprite2D
@onready var exit_area: Area2D

func _ready() -> void:
	update_art()
	update_exit_area()
	
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
	
func exit_direction() -> Vector2:
	if exit_side == enums.pipe_side.NONE:
		return Vector2.ZERO
	var local_side: Vector2 = DIRECTIONS[exit_side]
	return local_side.rotated(global_rotation).round()
	
func has_opening(direction: Vector2) -> bool:
	match shape: #from enums (if adding, add to enums as well)
		enums.pipe_shapes.STRAIGHT:
			return direction in [Vector2.LEFT, Vector2.RIGHT]
		enums.pipe_shapes.ELBOW:
			return direction in [Vector2.RIGHT, Vector2.DOWN]
		enums.pipe_shapes.T_SHAPE:
			return direction in [Vector2.RIGHT, Vector2.LEFT, Vector2.DOWN]
		enums.pipe_shapes.CROSS:
			return direction in [Vector2.UP,Vector2.LEFT, Vector2.DOWN, Vector2.RIGHT]
	return false
	
func connects_pipe(other: PipePiece) -> bool: 
	var offset = other.global_position - global_position
	for direction in [Vector2.RIGHT, Vector2.LEFT, Vector2.UP, Vector2.DOWN]:
		if offset.is_equal_approx(direction * tile_size):
			return has_opening_exit(direction) and other.has_opening_exit(-direction)
	return false
	
func pipe_location(world_position: Vector2) -> PipePiece:
	for pipe: PipePiece in get_tree().get_nodes_in_group("pipe_pieces"):
		if pipe.global_position.is_equal_approx(world_position):
			return pipe
	return null
	
func connected_pipe (direction: Vector2) -> PipePiece:
	#checks for other connected pipes and sees if player can go that way
	var neighbour = pipe_location(global_position + direction * tile_size)
	if neighbour != null and connects_pipe(neighbour):
		return neighbour
	return null

func can_enter(player: CharacterBody2D) -> bool:
	if exit_side == enums.pipe_side.NONE: return false
	return exit_area.overlaps_body(player) and exit_clear(player)

func exit_clear(player: CharacterBody2D) -> bool:
	if exit_side == enums.pipe_side.NONE: return false
	for body in exit_area.get_overlapping_bodies():
		if body != player : return false
		
	var direction: Vector2 = DIRECTIONS[exit_side]
	return pipe_location(to_global(direction * tile_size)) == null
	
func update_art() -> void:
	pipe_art = get_node_or_null("pipe_art") as Sprite2D
	if pipe_art == null:
		return
	
	var pieces: Dictionary = PIPES[shape]
	var index = clampi(pipe_variant, 0, pieces.size() - 1)
	var top_left : Vector2i = pieces.values()[index]
		
	pipe_art.texture = art_sheet
	pipe_art.region_enabled = true
	pipe_art.region_rect = Rect2(top_left.x, top_left.y, tile_size, tile_size)
	pipe_art.rotation_degrees = 0.0
	pipe_art.flip_v = false
	
	match shape:
		enums.pipe_shapes.STRAIGHT:
			pipe_art.rotation_degrees = 90.0
		enums.pipe_shapes.ELBOW:
			if top_left == pieces["Eyes"]: pipe_art.flip_v = true
			else:
				pipe_art.rotation_degrees = 180.0
		enums.pipe_shapes.T_SHAPE:
			pipe_art.flip_v = true
			
func update_exit_area() -> void:
	exit_area = get_node_or_null("exit_area") as Area2D
	if exit_area == null:
		return
		
	exit_area.monitoring = exit_side != enums.pipe_side.NONE
	exit_area.visible = exit_area.monitoring
	if exit_side == enums.pipe_side.NONE:
		return
	var direction: Vector2 = DIRECTIONS[exit_side]
	exit_area.position = direction * (tile_size/2)
	exit_area.rotation = direction.angle()
	
#validate property: Godot calls this when prepping the inspector for fields. 
#Pipes have shapes and certain shapes have exits but others dont
#Which dropdowns should be shown for mouth per pipe piece shape?

func _validate_property(property: Dictionary) -> void:
	if property.name != &"exit_side":
		return

	var options := PackedStringArray(["None:%d" % enums.pipe_side.NONE])
	if has_opening(Vector2.UP): options.append("North:%d" % enums.pipe_side.UP)
	if has_opening(Vector2.RIGHT): options.append("East:%d" % enums.pipe_side.RIGHT)
	if has_opening(Vector2.DOWN): options.append("South:%d" % enums.pipe_side.DOWN)
	if has_opening(Vector2.LEFT): options.append("West:%d" % enums.pipe_side.LEFT)

	property.hint = PROPERTY_HINT_ENUM
	property.hint_string = ",".join(options)
