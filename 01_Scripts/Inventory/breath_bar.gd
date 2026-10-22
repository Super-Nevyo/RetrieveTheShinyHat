extends Control
class_name BreathBar

@export var bar : TextureProgressBar

func set_breath_bar(value:float):
	bar.value = value
