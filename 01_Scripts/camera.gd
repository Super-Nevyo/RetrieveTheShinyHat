extends Camera2D

@onready var origin : Vector2 = position
var shake_strength = 10
var shake_time = 0
@export var shake_speed = Vector2(20,13)

func _ready() -> void:
	PuzzleSignalTransmiter.shake_screen.connect(shake_screen)

func _exit_tree() -> void:
	PuzzleSignalTransmiter.shake_screen.disconnect(shake_screen)

func _physics_process(delta: float) -> void:
	if shake_time > 0: shake_time -= delta
	else: shake_time = 0
	position.x = origin.x + (sin(shake_time * shake_speed.x) * shake_strength)
	position.y = origin.y + (sin(shake_time * shake_speed.y) * shake_strength)

func shake_screen(strength : float, time : float):
	if shake_time > 0:
		return
	shake_strength = strength
	shake_time = time
