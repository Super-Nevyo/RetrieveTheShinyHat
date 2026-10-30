class_name PlayerInputHandler

var direction : Vector2 = Vector2.ZERO
var jump_just_pressed : bool = false
var jump_pressed : bool = false
var jump_unpressed : bool = false

var attack_just_pressed : bool = false
var attack_pressed : bool = false
var attack_unpressed : bool = false

func get_input():
	direction.x = Input.get_axis("move_left", "move_right")
	direction.y = Input.get_axis("move_up", "move_down")
	jump_just_pressed = false
	jump_unpressed = false
	if Input.is_action_pressed("jump"):
		if !jump_pressed:
			jump_just_pressed = true
		jump_pressed = true
	else:
		if jump_pressed:
			jump_unpressed = true
		jump_pressed = false

	attack_just_pressed = false
	attack_unpressed = false
	if Input.is_action_pressed("attack"):
		if !attack_pressed:
			attack_just_pressed = true
		attack_pressed = true
	else:
		if attack_pressed:
			attack_unpressed = true
		attack_pressed = false
