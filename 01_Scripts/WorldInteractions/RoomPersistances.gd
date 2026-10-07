extends Node
class_name RoomPersistances

#dictionary of active puzzles in a room, needs to know what room is it, what is the puzzle and wether is on or off
var activepuzzles = {}
enum meta_puzzles {NULL, RISING_ACID}
var meta_puzzle_values : Dictionary[meta_puzzles,int] = {meta_puzzles.NULL : 0, meta_puzzles.RISING_ACID : 0}
var revealedsecrets = {} #dictionary of secret rooms

#records the puzzle that was activated
func remember_active(puzzle_id: String, room_id: String, is_active: bool) -> void:
	if not activepuzzles.has(room_id): #does this room need a new dictionary for their active things?
		activepuzzles [room_id] = {}
		
	activepuzzles[room_id][puzzle_id] = is_active #stores the puzzle state

func puzzle_state (puzzle_id: String, room_id: String) -> bool:
	return activepuzzles [room_id][puzzle_id]
	
	
func remember_secret(room_id: String, reveal_id: String) -> void:
	if not revealedsecrets.has(room_id):
		revealedsecrets [room_id] = {}
	revealedsecrets[room_id][reveal_id] = true
	
func is_revealed(room_id: String, reveal_id: String) -> bool:
	if not revealedsecrets.has(room_id):
		return false
	
	if not revealedsecrets[room_id].has(reveal_id):
		return false
	
	return revealedsecrets[room_id][reveal_id]

func change_meta(id: meta_puzzles, amount: int):
	meta_puzzle_values[id] += amount

func _enter_tree() -> void:
	PuzzleSignalTransmiter.activate_meta.connect(change_meta)
	
func _exit_tree() -> void:
	PuzzleSignalTransmiter.activate_meta.disconnect(change_meta)
