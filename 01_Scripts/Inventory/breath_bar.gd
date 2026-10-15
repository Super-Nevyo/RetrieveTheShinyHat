extends Control
class_name BreathBar

@export var bar : TextureProgressBar
var oxygen_tween: Tween #it's already added omg

func set_breath_bar(value:float):
	bar.value = value
	if oxygen_tween: 
		oxygen_tween.kill()
	
	oxygen_tween = create_tween()
