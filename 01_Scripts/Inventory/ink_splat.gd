extends Area2D
class_name InkSplat

@export var splat_duration: float = 10
@onready var lifetime: Timer = $Timer
var attached_entity: Array[Box] = []


func _ready() -> void:
	body_entered.connect(_on_body_entered)
	lifetime.timeout.connect(_on_fade)
	lifetime.start(splat_duration)

func _physics_process(_delta: float) -> void:
	for body in get_overlapping_bodies():
		if body is Box:
			if body.attach_to_ink(self):
				if not attached_entity.has(body):
					attached_entity.append(body)

func _on_body_entered (body: Node2D) -> void:
	if body is Box:
		print("Ink is on box now wiwiwiwi")

func _on_fade() -> void:
	set_physics_process(false)
	_release_boxes()
	queue_free()

func _exit_tree() -> void:
	_release_boxes()

func _release_boxes() -> void:
	for box in attached_entity:
		if is_instance_valid(box):
			box.release_from_ink(self)

	attached_entity.clear()
