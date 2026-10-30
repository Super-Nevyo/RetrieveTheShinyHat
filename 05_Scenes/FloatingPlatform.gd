extends RigidBody2D
class_name FloatingPlatform
#Hookes Law: force is proportional to the distance of strech or compress. Elasticity.
#F = -kx (Force = - object stiffness x distance stretch or squish
#pulling the platform up makes the - pull it back down)

@export var acid_surface: LiquidDetector
@export var stiffness: float = 1
@export var bouyancy_depth: float = 10
@export var float_height: float = 8.0
var liquid: Liquid = null

#Damp force = -linear velocity+damping strenght
#@export var damping: float = 10.0

func _physics_process(_delta: float) -> void:
	if liquid == null or not is_instance_valid(liquid) or liquid.surface == null:
		constant_force = Vector2.ZERO
		return
	var target_y: float = liquid.surface.global_position.y - float_height
	var depth: float = global_position.y - target_y
	if depth >= 0: #if its at water level
		#hookes law applied here
		var limited_depth: float = minf(depth, bouyancy_depth)
		var bouyancy_force: float = stiffness * limited_depth
		#var damp_force = -linear_velocity.y * damping
		
		constant_force = Vector2 (0, -bouyancy_force) #built positional force
	
	else:
		constant_force = Vector2.ZERO
