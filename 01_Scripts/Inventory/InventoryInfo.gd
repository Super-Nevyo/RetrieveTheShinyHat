class_name InventoryInfo

var Items:Array[Item] = [null,null,null,null]
var Player: PlayerController
# add a copy of the map information too

func _init(player: PlayerController) -> void:
	Player = player

func AddItem(item: Item, slot: int) -> void:
	if Items[slot] != null:
		Items[slot].Exit(Player)
	Items[slot] = item
	Items[slot].Enter(Player)
