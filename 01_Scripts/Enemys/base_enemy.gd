extends RigidBody2D
class_name Enemy


@export var MyStateMachine : EnemyStateMachine
var MyInfo : Dictionary

func _physics_process(delta: float) -> void:
	MyStateMachine.update(self,MyInfo)
