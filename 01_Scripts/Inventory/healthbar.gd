extends Control
class_name Healthbar

@export var bar : TextureProgressBar
var health_tween: Tween #it's already added omg

func change_healthbar(new:float, max:float) -> void:
	#bar.value = (new/max)*100
	
	var target: float = clampf((new/max) * 100,0,100)
	if health_tween: health_tween.kill()
	health_tween = create_tween()
	health_tween.tween_property(bar,"value", target, 0.2)
