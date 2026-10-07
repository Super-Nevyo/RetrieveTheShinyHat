extends MetaActivated

@onready var liquid_transform : Node2D = $LiquidTransform
@onready var bottom_level : float = liquid_transform.position.y
@export var partly_filled_liquid_level : float = 250
@export var room_level = 1
var move_to : float = 0
@export var move_speed : float = 100
@export var jump_distance : float = 5

func _physics_process(delta: float) -> void:
	if !concluded:
		liquid_transform.position.y += delta * move_speed * (1 if liquid_transform.position.y < move_to else -1)
		if abs(liquid_transform.position.y - move_to) < jump_distance:
			concluded = true

func activate_puzzle(id: RoomPersistances.meta_puzzles, new:int) -> void:
	super.activate_puzzle(id, new)
	move_to = where_to_move()

func set_puzzle(new:int) -> void:
	super.set_puzzle(new)
	move_to = where_to_move()
	liquid_transform.position.y = move_to
	concluded = true


func where_to_move() -> float:
	if activation_amount == room_level: return partly_filled_liquid_level
	elif activation_amount < room_level: return bottom_level
	else: return 0
