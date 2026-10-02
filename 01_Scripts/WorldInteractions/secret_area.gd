extends Node2D
class_name SecretArea

@export var room_id: String
@export var reveal_id: String

@onready var cover: CanvasItem = $Cover
@onready var reveal_trigger: Area2D = $Trigger

var persistance: RoomPersistances


func _ready() -> void:
	persistance = get_tree().get_first_node_in_group("room_persistance") as RoomPersistances
	
	if persistance != null and persistance.is_revealed(room_id, reveal_id):
		reveal_now()

func reveal() -> void:
	if persistance != null:
		persistance.remember_secret(room_id, reveal_id)

	cover.visible = false

	reveal_trigger.set_deferred("monitoring", false)


func reveal_now() -> void:
	cover.visible = false
	reveal_trigger.set_deferred("monitoring", false)

func _on_reveal_trigger_body_entered(body: Node2D) -> void:
	if body is PlayerController:
		reveal()
