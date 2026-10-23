extends Node2D

@onready var iris : Sprite2D = $Iris
@export var movement_pattern : EyeMovement
@export var does_idle = true
var player : PlayerController
var target_position : Vector2 = Vector2(0,0)

func _physics_process(delta: float) -> void:
	if player != null:
		movement_pattern.target_player(player.position, position, iris, delta) #run the stratagy pattern
	elif does_idle:
		target_position = movement_pattern.idle(position, iris, delta, target_position)

func _on_player_detection_body_entered(body: Node2D) -> void:
	if body is PlayerController:
		player = body


func _on_player_detection_body_exited(body: Node2D) -> void:
	if body is PlayerController:
		player = null
