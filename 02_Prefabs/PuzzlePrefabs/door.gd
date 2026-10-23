extends Node2D

signal door_entered(player : PlayerController)
var player : PlayerController
@onready var touch_indicator : Node2D = $TouchIndicator

func _physics_process(delta: float) -> void:
	if player != null:
		if Input.is_action_just_pressed("move_up"):
			door_entered.emit(player)

func _on_area_body_entered(body: Node2D) -> void:
	if body is PlayerController:
		player = body
		touch_indicator.visible = true


func _on_area_body_exited(body: Node2D) -> void:
	if body is PlayerController:
		player = null
		touch_indicator.visible = false
