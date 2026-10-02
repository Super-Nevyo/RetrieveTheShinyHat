extends Node2D
class_name BrainBoss

@onready var brain_anim: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	brain_anim.play("Idle")
	
#func ending_animation() -> void:
	#brain_anim.play("Idle")
	#change to something else later for destroying the brain/exploding etc
