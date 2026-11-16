extends Node2D
class_name BrainBoss

@onready var brain_anim: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	match GlobalAudio.current_area:
		GlobalAudio.BodyAreaMusic.penis, GlobalAudio.BodyAreaMusic.penis_boss:
			brain_anim.play("PenisBoss")
		GlobalAudio.BodyAreaMusic.stomach, GlobalAudio.BodyAreaMusic.stomach_boss:
			brain_anim.play("StomachBoss")
	
#func ending_animation() -> void:
	#brain_anim.play("Idle")
	#change to something else later for destroying the brain/exploding etc
