extends Node2D
class_name RoomTransition

signal transition_started(transition_id: String)

@export var transition_data: RoomTransitionData

func _ready() -> void:
	$Trigger.body_entered.connect(_on_trigger_body_entered)

func _on_trigger_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		print("Transition started from ", transition_data.transition_id)
		
		#this is what emits the signal (emit)
		transition_started.emit(transition_data.transition_id) #scriptable objects are back babyyyyy
	
