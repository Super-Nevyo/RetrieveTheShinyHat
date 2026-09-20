extends RigidBody2D

#Hookes Law: force is proportional to the distance of strech or compress. Elasticity.
#F = -kx (Force = - object stiffness x distance stretch or squish
#pulling the platform up makes the - pull it back down)

@export var water_level: float = 500.0
@export var stiffness: float = 1.0
#@export var damping: float = 1.0

func _physics_process(delta: float) -> void:
	
	var depth: float = global_position.y - water_level
	
	if depth >= 0: #if its at water level
		#hookes law applied here
		var bouyancy_force: float = stiffness * depth
		constant_force = Vector2 (0, -bouyancy_force) #built positional force
	
