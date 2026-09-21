extends RigidBody2D
class_name FloatingPlatform
#Hookes Law: force is proportional to the distance of strech or compress. Elasticity.
#F = -kx (Force = - object stiffness x distance stretch or squish
#pulling the platform up makes the - pull it back down)

@export var acid_surface: Marker2D
@export var stiffness: float = 1.0

#Damp force = -linear velocity+damping strenght
@export var damping: float = 10.0

func _physics_process(_delta: float) -> void:
	
	var depth: float = global_position.y - acid_surface.global_position.y
	
	if depth >= 0: #if its at water level
		#hookes law applied here
		var bouyancy_force: float = stiffness * depth
		var damp_force = -linear_velocity.y * damping
		
		constant_force = Vector2 (0, -bouyancy_force + damp_force) #built positional force
	
	else:
		constant_force = Vector2.ZERO
		
# to add: calculate the force 
