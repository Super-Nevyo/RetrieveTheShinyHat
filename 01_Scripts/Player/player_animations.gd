extends Node
class_name PlayerAnimations

@export var player_anim: AnimatedSprite2D
@export var item_anim: AnimationPlayer
@export var head_mark: Node2D
@export var snorkel: Sprite2D

func item_animation() -> void:
	head_mark.scale.x = -1 if player_anim.flip_h else 1
	
	var animation_name = player_anim.animation
	if not item_anim.has_animation(animation_name):
		animation_name = &"Idle"
	
	if item_anim.assigned_animation != animation_name:
		item_anim.play(animation_name)
