extends Control
class_name BreathBar

@onready var bar : ProgressBar = $ProgressBar

func set_breath_bar(value:float):
	bar.value = value
