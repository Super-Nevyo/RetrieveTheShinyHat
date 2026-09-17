extends Node2D

@export var starting_room: PackedScene #calls a godot scene prefab
@export var room_container: Node2D
@export var test_room: PackedScene

#var is_transitioning: bool

#rooms
var current_room: Node2D #will need id and resource later

func _ready() -> void:
	load_room(starting_room)

func load_room(room_scene: PackedScene) -> void:
	if room_scene == null:
		print("Assign a room scene in the inspector")
		return
	
	if is_instance_valid(current_room):
		current_room.queue_free()
	
	current_room = room_scene.instantiate()
	
	for child in current_room.get_children(): #needed to get children nodes and look for them
		if child is RoomTransition: #if the node uses the room transition script the connect the signal
			child.transition_started.connect(_on_transition_started) #connects listener
	
	room_container.add_child.call_deferred(current_room) #ask room container to add the room to a child

func _on_transition_started(transition_id: String) -> void: #calls the transition data resource
	print("Manager received exit ID: ", transition_id)


#func _input(event: InputEvent) -> void:
#	handle_test_input(event)

#func handle_test_input(event: InputEvent) -> void:
#	if event.is_action_pressed("test_transition") and not event.is_echo():
#		print("Called room change test")
#		load_room(test_room)
