@abstract extends Resource
class_name EyeMovement

@abstract func target_player(target : Vector2, start : Vector2, iris : Sprite2D, delta : float) -> void

@abstract func idle(start : Vector2, iris : Sprite2D, delta : float, target_position : Vector2) -> Vector2
