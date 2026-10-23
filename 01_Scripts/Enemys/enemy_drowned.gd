extends EnemyState
class_name Drowned

func update(enemy : Enemy, info : Dictionary):
	enemy.linear_velocity.x = 0
	
func start(enemy : Enemy, info : Dictionary):
	enemy.gravity_scale = 1
	enemy.linear_velocity = Vector2.ZERO

func exit(enemy : Enemy, info : Dictionary):
	enemy.gravity_scale = 1
