extends puzzle_activated

@export var on_sprite : Sprite2D

func _ready() -> void:
	if (ActivationAmount >= 1):
		on_sprite.visible = true
	else:
		on_sprite.visible = false


func activate_puzzle(id: int, Amount: float):
	if id == signal_id:
		ActivationAmount += Amount
		if (ActivationAmount >= 1):
			on_sprite.visible = true
		else:
			on_sprite.visible = false
	
