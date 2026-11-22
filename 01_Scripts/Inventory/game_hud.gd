extends Control
class_name GameHud

@onready var hp_bar: Healthbar = $Healthbar
@onready var inv_ui: InventoryUI = $InventoryUi
@onready var breath_bar: BreathBar = $BreathBar
@onready var Player: PlayerController = $"../../PlayerCharacter"
@onready var collectible_counter: Label = $WormCounter/Counter

func _ready() -> void:
	if Player != null:
		Player.HealthChanged.connect(change_healthbar)
		Player.ItemCollected.connect(change_inventory_UI)
		Player.BreathChanged.connect(set_breath_bar)
		Player.ItemHovered.connect(hover_inventory_UI)
	var collect = get_tree().get_first_node_in_group("room_persistance") as RoomPersistances
	if collect != null:
		collect.collectible_count_up.connect(update_collectible_counter)
		update_collectible_counter(collect.collectible_count())

func change_healthbar(new:float, maxHP:float) -> void:
	hp_bar.change_healthbar(new,maxHP)

func change_inventory_UI(index: int, item: Item) -> void:
	inv_ui.ChangeInventoryUI(index,item.tex)

func hover_inventory_UI(index: int) -> void:
	inv_ui.HoverInventoryUI(index)

func set_breath_bar(value:float) ->void:
	breath_bar.set_breath_bar(value)

func update_collectible_counter(total: int) -> void:
	collectible_counter.text = str(total)
