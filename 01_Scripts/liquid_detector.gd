extends Area2D
class_name LiquidDetector

signal liquid_entered
signal liquid_exited


func _on_area_entered(area: Area2D) -> void:
	if area is Liquid:
		liquid_entered.emit()


func _on_area_exited(area: Area2D) -> void:
	if area is Liquid:
		liquid_exited.emit()
