extends Area2D
class_name EndGameTrigger

@onready var timeline: AnimationPlayer = $EndingAnimation
@onready var cinematic_player: AnimatedSprite2D = $"../CinematicPlayer"


func _on_body_entered (body: Node2D) -> void:
	if body is PlayerController:
		body.set_physics_process(false)
		print("trigger touched")
		body.visible = false
		cinematic_player.visible = true

		set_deferred("monitoring", false)
		timeline.play("EndingAnimation")
		await timeline.animation_finished
		get_tree().change_scene_to_file("res://05_Scenes/_DemoScenes/WinScene.tscn")
