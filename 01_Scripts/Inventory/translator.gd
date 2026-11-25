extends Item
class_name Translator

func Enter(Player: PlayerController):
	PuzzleSignalTransmiter.speaking.connect(Translate)
	pass

func Exit(Player: PlayerController):
	PuzzleSignalTransmiter.speaking.disconnect(Translate)
	pass

func Translate(node : Control):
	node.visible = true
