extends Resource
class_name EnemyState

func Update(enemy : Enemy, info : Dictionary) -> Dictionary:
	print("updated")
	return info

func Start(enemy : Enemy, info : Dictionary) -> Dictionary:
	return info

func Exit(enemy : Enemy, info : Dictionary) -> Dictionary:
	return info
