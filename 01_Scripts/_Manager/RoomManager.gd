extends Node2D

@export var starting_room: MapRoom

@export var room_container: Node2D

@export var world_map: WorldMap
@export var player: CharacterBody2D

#var is_transitioning: bool
#rooms
var current_room: Node2D
var current_room_id: String

@export var activated_puzzles: RoomPersistances

func _ready() -> void:
	load_room(starting_room.room_scene, starting_room.room_id)

func load_room(room_scene: PackedScene, room_id: String) -> void:
	
	if room_scene == null:
		print("Assign a room scene in the inspector")
		return
	
	if is_instance_valid(current_room):
		
		for child in current_room.get_children(): 
			if child is PuzzleActivator:
				activated_puzzles.remember_active(child.puzzle_id, current_room_id, child.SwitchFlipped) #calls dictionary
		
		current_room.queue_free() #room gets removed
	
	current_room_id = room_id
	current_room = room_scene.instantiate()
	
	for child in current_room.get_children(): #needed to get children nodes and look for them
		if child is RoomTransition: #if the node uses the room transition script the connect the signal
			child.transition_started.connect(_on_transition_started) #connects listener
	
	room_container.add_child.call_deferred(current_room) #ask room container to add the room to a child
	await current_room.ready
	
	if activated_puzzles.activepuzzles.has(current_room_id):
		for child in current_room.get_children():
			if child is PuzzleActivator:
				var remembered_state: bool = activated_puzzles.puzzle_state(child.puzzle_id, current_room_id)
				
				if child.SwitchFlipped != remembered_state:
					child.ActivatePuzzle()


func _on_transition_started(transition_id: String) -> void: #Signals the world map to find the connection to an exit
	
	var connection = world_map.find_connection(transition_id)
	print("Touched: ", connection.name)
	
	var _new_destination: MapRoom
	var _destination_exit_id: String
	
	#if the player uses a connection, the system knows what exit to spawn the player.
	# End to end connection (what room and what exit in that room, not amount of exits)
	
	if transition_id == connection.exit_a_id:
		_new_destination = connection.room_b
		_destination_exit_id = connection.exit_b_id
	else:
		_new_destination = connection.room_a
		_destination_exit_id = connection.exit_a_id
	
	await load_room(_new_destination.room_scene, _new_destination.room_id)

	var room_metadata = current_room.get_node("MapMetadata") as MapMetadata
	var room_exit = room_metadata.find_exit(_destination_exit_id)
	var arrival_point = room_exit.get_arrival_point() #need the marker2d global position later
	
	player.global_position = arrival_point.global_position
