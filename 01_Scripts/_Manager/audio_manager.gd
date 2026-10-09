extends Node

@export var bg_music_player: AudioStreamPlayer

const bg_music = {
	GlobalAudio.BodyAreaMusic.stomach: "stomach_music",
	GlobalAudio.BodyAreaMusic.stomach_boss: "boss_music"
}

var current_area: int = -1

func _process(_delta: float) -> void:
	if current_area != GlobalAudio.current_area:
		current_area = GlobalAudio.current_area
		bg_music_player["parameters/switch_to_clip"] = bg_music[current_area]
