extends Node2D

@export var door1 : Node2D
@export var door2 : Node2D

func _on_door1_entered(player: PlayerController) -> void:
		player.position = door2.global_position


func _on_door2_entered(player: PlayerController) -> void:
		player.position = door1.global_position
