extends Node2D
@export var starting_room: PackedScene #calls a godot scene prefab
@export var room_container: Node2D
@export var test_room: PackedScene

#rooms
var current_room: Node2D #will need id and resource later

func _ready() -> void:
	load_room(starting_room)

func load_room(room_scene: PackedScene) -> void:
	if is_instance_valid(current_room):
		current_room.queue_free()
	
	current_room = room_scene.instantiate()
	room_container.add_child.call_deferred(current_room) #ask room container to add the room to a child
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("test_transition") and not event.is_echo():
		print("Called room change test")
		load_room(test_room)
