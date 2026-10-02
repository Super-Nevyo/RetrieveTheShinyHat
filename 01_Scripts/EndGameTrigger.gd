extends Area2D
class_name EndGameTrigger

@onready var timeline: AnimationPlayer = $EndingAnimation
@onready var cinematic_player: AnimatedSprite2D = $"../CinematicPlayer"

var has_started: bool = false

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered (body: Node2D) -> void:
	if has_started:
		return
		
	if body is PlayerController:
		
		has_started = true		
		print("trigger touched")
		
		body.set_physics_process(false)
		body.velocity = Vector2.ZERO
		body.visible = false
		
		cinematic_player.visible = true

		set_deferred("monitoring", false)
		timeline.play("EndingAnimation")
		await timeline.animation_finished
		get_tree().change_scene_to_file("res://05_Scenes/_DemoScenes/WinScene.tscn")
