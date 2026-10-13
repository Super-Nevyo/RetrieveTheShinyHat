class_name InventoryInfo

var Items:Array[Item] = [null,null,null,null]
var Player: PlayerController
# add a copy of the map information too

func _init(player: PlayerController) -> void:
	Player = player

func AddItem(item: Item, slot: int) -> void:
	var dupe = 0
	if Items[slot] != null:
		for i in Items:
			if i == Items[slot]:
				dupe += 1
		if dupe == 1:
			Items[slot].Exit(Player)
	Items[slot] = item
	dupe = 0
	for i in Items:
		if i == Items[slot]:
			dupe += 1
	if dupe == 1:
		Items[slot].Enter(Player)
