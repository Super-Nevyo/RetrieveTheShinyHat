#this is a room in the world

extends Node2D
class_name MapRoom

@export var room_id: String
@export var room_scene: PackedScene

func _ready() -> void:
	print(room_id, " exit count: ", get_all_exits().size())
	
func get_all_exits() -> Array[RoomTransitionData]: #always start with an empty list
	var exits: Array[RoomTransitionData] = []
	
	var new_room = room_scene.instantiate()
	var metadata = new_room.get_node_or_null("MapMetadata") #make sure ALL rooms carry this node!!
	print(room_id, "Metadata script found!")
	
	if metadata is MapMetadata :
		print("I have some exits: ", metadata.transitions.size()) #size to return the elements in the array
		exits = metadata.get_exit_data()
	
	new_room.free() # THIS IS TEMPORARY UNTIL CORPSE RECOVERY IS ADDED!
	return exits
	
