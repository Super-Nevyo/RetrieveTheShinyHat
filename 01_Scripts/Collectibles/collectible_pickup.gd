extends Area2D
class_name CollectiblePickup

@export var data: CollectibleData
@onready var collection = get_tree().get_first_node_in_group("room_persistance") as RoomPersistances

func _ready() -> void:
	if collection != null and collection.has_collectible(data.collectible_id):
		queue_free()
		return
	$Sprite2D.texture = data.texture
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		queue_free()
