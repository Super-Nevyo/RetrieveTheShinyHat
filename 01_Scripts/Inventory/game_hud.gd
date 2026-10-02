extends Control
class_name GameHud

@onready var hp_bar: Healthbar = $Healthbar
@onready var inv_ui: InventoryUI = $InventoryUi
@onready var breath_bar: BreathBar = $BreathBar
@onready var Player: PlayerController = $"../PlayerCharacter"

func _ready() -> void:
	if Player != null:
		Player.HealthChanged.connect(change_healthbar)
		Player.ItemCollected.connect(change_inventory_UI)
		Player.BreathChanged.connect(set_breath_bar)

func change_healthbar(new:float, maxHP:float) -> void:
	hp_bar.change_healthbar(new,maxHP)

func change_inventory_UI(index: int, item: Item) -> void:
	inv_ui.ChangeInventoryUI(index,item.tex)

func set_breath_bar(value:float) ->void:
	breath_bar.set_breath_bar(value)
