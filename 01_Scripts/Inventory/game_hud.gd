extends Control
class_name GameHud

@onready var HPBar: Healthbar = $Healthbar
@onready var InvUI: InventoryUI = $InventoryUi
@onready var Player: PlayerController = $"../PlayerCharacter"

func _ready() -> void:
	if Player != null:
		Player.HealthChanged.connect(change_healthbar)
		Player.ItemCollected.connect(change_inventory_UI)

func change_healthbar(new:float, max:float) -> void:
	HPBar.change_healthbar(new,max)

func change_inventory_UI(index: int, tex: Texture2D) -> void:
	InvUI.ChangeInventoryUI(index,tex)
