extends Control



func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://05_Scenes/_DemoScenes/Gameplay.tscn")


func _on_quit_button_pressed() -> void:
	get_tree().quit()
