extends Node2D
# knows all room entries and what connections lead to what room (where does this exit lead?)

class_name WorldMap

#find each connection in worldmap child and check if its a map transition.
#Check if the connection matches a specified id for a room and return the match

func find_connection(exit_id: String) -> MapTransition:
	for folder in get_children():
		for connection in folder.get_children():
			if connection is MapTransition:
				if exit_id == connection.exit_a_id or exit_id == connection.exit_b_id:
					return connection
	return null
