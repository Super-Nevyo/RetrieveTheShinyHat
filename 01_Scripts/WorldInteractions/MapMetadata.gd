#this is to make it so it knows how many exits are in my room

class_name MapMetadata
extends Node2D

@export var transitions: Array[RoomTransition] = [] #all the room exists IDs will populate here

func get_exit_data() -> Array[RoomTransitionData]:
	var exits: Array[RoomTransitionData] = [] #makes an empty array of ids and names every time it returns
	
	for transition in transitions:
		if transition != null and transition.transition_data != null:
			exits.append(transition.transition_data) #append = adds to the end of the array
	
	return exits
	
func find_exit(exit_id: String) -> RoomTransition: #finds the actual transition node
	
	for transition in transitions:
		if transition.transition_data.transition_id == exit_id:
			return transition
			
	return null

#to add: The map shape of the mini map here when they are set
