extends Node
class_name RoomPersistances

#dictionary of active puzzles in a room, needs to know what room is it, what is the puzzle and wether is on or off
var activepuzzles = {}

#records the puzzle that was activated
func remember_active(puzzle_id: String, room_id: String, is_active: bool) -> void:
	if not activepuzzles.has(room_id): #does this room need a new dictionary for their active things?
		activepuzzles [room_id] = {}
		
	activepuzzles[room_id][puzzle_id] = is_active #stores the puzzle state
	

func puzzle_state (puzzle_id: String, room_id: String) -> bool:
	return activepuzzles [room_id][puzzle_id]
