extends Control
class_name Healthbar

@onready var bar : ProgressBar = $PanelContainer/MarginContainer/ProgressBar

func change_healthbar(new:float, max:float) -> void:
	bar.value = (new/max)*100
