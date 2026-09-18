extends Node2D

@export var starting_room: PackedScene #calls a godot scene prefab
@export var test_room: PackedScene

@export var room_container: Node2D

@export var world_map: WorldMap
@export var player: CharacterBody2D


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

func _on_transition_started(transition_id: String) -> void: #Signals the world map to find the connection to an exit
	
	var connection = world_map.find_connection(transition_id)
	print("Touched: ", connection.name)
	
	var new_destination = MapRoom
	var destination_exit_id: String
	
	#if the player uses a connection, the system knows what exit to spawn the player. End to end connection (what room and what exit in that room, not amount of exits)
	
	if transition_id == connection.exit_a_id:
		new_destination = connection.room_b
		destination_exit_id = connection.exit_b_id
	else:
		new_destination = connection.room_a
		destination_exit_id = connection.exit_a_id
		
	

#func _input(event: InputEvent) -> void:
#	handle_test_input(event)

#func handle_test_input(event: InputEvent) -> void:
#	if event.is_action_pressed("test_transition") and not event.is_echo():
#		print("Called room change test")
#		load_room(test_room)
