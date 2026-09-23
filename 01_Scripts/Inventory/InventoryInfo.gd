class_name InventoryInfo

var Items:Array[Item]
var Player: PlayerController
# add a copy of the map information too

func _init(player: PlayerController) -> void:
	Player = player

func AddItem(item: Item, slot: int) -> void:
	Items[slot - 1].Exit(Player)
	Items[slot - 1] = item
	Items[slot - 1].Enter(Player)
	pass
