extends Node2D
# knows all room entries and what connections lead to what room (where does this exit lead?)

class_name WorldMap

#find each connection in worldmap child and check if its a map transition.
#Check if the connection matches a specified id for a room and return the match

func find_connection(exit_id: String) -> MapTransition:
	for connection in $Connections.get_children():
		if connection is MapTransition:
			if connection.exit_a_id == exit_id or connection.exit_b_id == exit_id:
				return connection
				
	return null
