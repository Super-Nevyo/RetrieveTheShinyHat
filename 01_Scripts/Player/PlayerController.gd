class_name PlayerController
extends CharacterBody2D

# Created from basic PlayerController script. To be modified.
# Player should: walk, attack, jump, climb ladders
# Extend later if theres time: swim, be launched?, dash, pogo?

#===SIGNALS
signal HealthChanged(new: float, maxHp: float)
signal ItemCollected(index: int, item: Item)
signal BreathChanged(breath:float)

#===MOVEMENT
# Ground
@export var speed: float = 300
@export var acceleration: float = 1800
@export var friction: float = 500
@export var sprint_mult: float = 1.5
var direction_x : float
var direction_y : float
var current_speed : float

# Submerged
@export var swim_speed: float = 300
@export var swim_acceleration: float = 800
@export var swim_friction: float = 100
var max_breath : float = 100 #this is 100 because the bar has a max of 100
@onready var current_breath : float = max_breath
@export var breath_decay : float = 1
@export var drown_dmg : float = 10
@export var drown_relief : float = 2
@export var submerged_cap : float = 40

var velo: Vector2 = Vector2.ZERO

#===JUMP
@export var jump_height : float = 100
@export var jump_time_full_up : float = 0.5
@export var jump_time_down : float = 0.4

@onready var jump_velocity: float = -(2.0 * jump_height) / jump_time_full_up
@onready var jump_gravity: float = (2.0 * jump_height) / (jump_time_full_up * jump_time_full_up)
@onready var fall_gravity: float = (2.0 * jump_height) / (jump_time_full_up * jump_time_down)

#===SWIM
var bodies_of_water:int = 0

#===ATTACK
@onready var attack_hit_box: CollisionShape2D = $AttackHitBox/HitBox
@onready var attack_collision: Area2D = $AttackHitBox
@export var attack_offset: float = 16
var is_attacking: bool = false

#===GETHIT
@export var MaxHP : float = 100
@onready var currentHP : float = MaxHP
@export var DmgLayer : int = 15
var isdead : bool = false

#===CARRYING
@onready var hold_position : Node2D = $HoldPosition
@export var throw_speed : float = 100

#===ANIMATION
@onready var player_anim: AnimatedSprite2D = $PlayerAnim #the $ is godots shortway of references. Also drag from scene tab into script

#===STATE MACHINE
@onready var MyStateMachine = PlayerStateMachine.new(self)

#===INVENTORY
@onready var MyInventory : InventoryInfo = InventoryInfo.new(self)

func _ready() -> void:
	MyStateMachine.Initialize(MyStateMachine.Move)

func _physics_process(delta: float) -> void:
	if isdead:
		return
	get_input()
	MyStateMachine.Update(delta)
	velocity = velo
	move_and_slide() #this is what is actually performing the movement
	
func get_input():
	direction_x = Input.get_axis("move_left", "move_right")
	direction_y = Input.get_axis("move_up", "move_down")
	if Input.is_action_just_pressed("jump"):
		MyStateMachine.Jump()
	
	if Input.is_action_pressed("sprint"):
		current_speed = speed * sprint_mult
	
	if Input.is_action_just_pressed("attack") and !is_attacking:
		MyStateMachine.Attack()


func get_custom_gravity():
	if velocity.y < 0.0:
		return jump_gravity
	else:
		return fall_gravity

func finish_attack():
	is_attacking = false
	player_anim.offset.x = 0
	attack_hit_box.set_deferred("disabled", true)
	

func _on_player_anim_animation_finished() -> void:
	if player_anim.animation == "Attack":
		player_anim.offset.x = 0
		finish_attack()

func take_damage(type: int,amount:float, ignore_invincible: bool = false):
	# maybe i should make a static function to handle this globally and better? # if enemies take damage, yes - tbd
	if isdead:
		return
		
	var was_hit = false
	if type % 2 == 1 && DmgLayer % 2 == 1:
		currentHP -= amount
		was_hit = true
	elif type % 4 == 2 && (DmgLayer - DmgLayer % 2) % 4 == 2:
		currentHP -= 2 * amount
		was_hit = true
	elif type % 8 == 4 && (DmgLayer - DmgLayer % 4) % 8 == 4:
		currentHP -= MaxHP * amount
		was_hit = true
	if was_hit:
		# trigger vfx related to dmg
		if currentHP > 0 and not ignore_invincible:
			$PlayerAnimations.play("Player_TakeDamage")
		
		HealthChanged.emit(currentHP,MaxHP)
		if currentHP > 0 and currentHP <= MaxHP * 0.33:
			$PlayerAnimations.play("Player_DmgThreshold")
		
		if currentHP <= 0:
			die()
	
	pass

func die():
	isdead = true
	set_physics_process(false)
	get_tree().change_scene_to_file("res://05_Scenes/_DemoScenes/LoseScene.tscn")

func change_water(entering:bool):
	if entering:
		bodies_of_water += 1
		if bodies_of_water == 1:
			MyStateMachine.ChangeState(MyStateMachine.Swim)
	else:
		bodies_of_water -= 1
		if bodies_of_water == 0:
			MyStateMachine.ChangeState(MyStateMachine.Fall)

func add_item(item:Item, index: int):
	MyInventory.AddItem(item,index)
	ItemCollected.emit(index,item)
	#inventoryUI.ChangeInventoryUI(index, item.tex)
	pass
