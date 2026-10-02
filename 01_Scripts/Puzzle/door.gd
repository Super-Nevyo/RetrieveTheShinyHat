extends puzzle_activated

@onready var DoorStartPosition:Vector2 = Door.position
@export var DoorMovePosition:Vector2 = Vector2(0,50)
@export var move_speed: float = 5

@export var Door: Node2D
var has_reached_position: bool = false 
var step : float = 0

func activate_puzzle(id: int, Amount: float):
	if id == signal_id:
		ActivationAmount += Amount
		has_reached_position = false


func _physics_process(delta: float) -> void:
	if !has_reached_position:
		if ActivationAmount >= 1:
			step = clamp(step + move_speed * delta,0,1)
			print(step)
			print(DoorMovePosition.y - DoorStartPosition.y)
			#Door.position = Vector2(lerp(Door.position.x, DoorMovePosition.x, abs(DoorMovePosition.x - DoorStartPosition.x) * move_speed),lerp(Door.position.y, DoorMovePosition.y, abs(DoorStartPosition.y - DoorMovePosition.y) * move_speed))
			Door.position = lerp(DoorStartPosition, DoorMovePosition, step)
			if abs((DoorMovePosition - Door.position).length())<0.1:
				has_reached_position = true
		else:
			step = clamp(step - move_speed * delta,0,1)
			#Door.position = Vector2(smoothstep(Door.position.x, DoorStartPosition.x, abs(DoorStartPosition.x - DoorMovePosition.x) * move_speed),smoothstep(Door.position.y, DoorStartPosition.y, abs(DoorStartPosition.y - DoorMovePosition.y) * move_speed))
			Door.position = lerp(DoorStartPosition, DoorMovePosition, step)
			if abs((DoorStartPosition - Door.position).length())<0.1:
				has_reached_position = true
