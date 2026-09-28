extends Area2D
class_name Acid


#player has been added to a group - call "player" group to take damage
#needs to move the marker so the platform detects movement - every physics frame?

@onready var acid_surface: Marker2D = $AcidSurface
@onready var starting_position: float = acid_surface.position.y
var time: float = 0.0

func move_marker_test() -> void:
	acid_surface.position.y = starting_position + sin(time) * 5

func _physics_process(delta: float) -> void:
	time += delta
	move_marker_test()
