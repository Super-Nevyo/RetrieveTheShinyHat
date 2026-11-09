extends Node

enum BodyAreaMusic
{
	stomach,
	stomach_boss,
	heart,
	lungs,
	background,
	penis,
	penis_boss,
	tumor,
	tumor_boss
}

var current_area: BodyAreaMusic = BodyAreaMusic.stomach #what area of the world the player is at
var music_volume: int
var sfx_volume: int
