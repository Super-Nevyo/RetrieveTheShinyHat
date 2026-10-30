class_name PlayerController
extends CharacterBody2D

# Created from basic PlayerController script. To be modified.
# Player should: walk, attack, jump, climb ladders
# Extend later if theres time: swim, be launched?, dash, pogo?

#===SIGNALS
signal HealthChanged(new: float, maxHp: float)
signal ItemCollected(index: int, item: Item)
signal ItemHovered(index: int)
signal BreathChanged(breath:float)

#===GOD MODE
var god_mode: bool = false
@export var god_speed: float = 1000

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
@export var swim_speed: float = 200
@export var swim_acceleration: float = 800
@export var swim_friction: float = 100
var max_breath : float = 100 #this is 100 because the bar has a max of 100
@onready var current_breath : float = max_breath
@export var breath_decay : float = 1
@export var drown_dmg : float = 10
@export var drown_relief : float = 2
@export var submerged_cap : float = 40

# BallMode
var has_ball: bool = false
@export var ball_speed: float = 350
@export var ball_acceleration: float = 1800
@export var ball_friction: float = 200
@export var ball_small_jump: float = 200
@export var ball_fast_jump: float = 400
@export var ball_jump_speed: float = 200


var velo: Vector2 = Vector2.ZERO

#===JUMP
@export var jump_height : float = 100
@export var jump_time_full_up : float = 0.5
@export var jump_time_down : float = 0.4

@onready var jump_velocity: float = -(2.0 * jump_height) / jump_time_full_up
@onready var jump_gravity: float = (2.0 * jump_height) / (jump_time_full_up * jump_time_full_up)
@onready var fall_gravity: float = (2.0 * jump_height) / (jump_time_full_up * jump_time_down)
@onready var swim_audio: AudioStreamPlayer2D = $PlayerAudio/Swim

#===SWIM
var bodies_of_water:int = 0
@onready var liquid_counter : LiquidCounter = LiquidCounter.new()

#===ATTACK
@onready var attack_hit_box: CollisionShape2D = $ArmAnchor/WhackPivotPoint/AttackHitBox/HitBox
@onready var attack_collision: Area2D = $ArmAnchor/WhackPivotPoint/AttackHitBox
@onready var attack_tentacle: Sprite2D = $ArmAnchor/WhackPivotPoint/WhackTentacle
@onready var attack_anim: AnimationPlayer = $PlayerAttackAnimations
@onready var arm_anchor: Node2D = $ArmAnchor

var is_attacking: bool = false
#@export var attack_offset: float = 16

#===GETHIT
@export var MaxHP : float = 100
@onready var currentHP : float = MaxHP
@export var DmgLayer : int = 15
@export var invincibilityframes : int = 500
@export var dead_delay: float = 0.3
var isdead : bool = false
var ishurt: bool = false
@onready var hitframe : int = -invincibilityframes
func isinvincible() -> bool: return (Time.get_ticks_msec() - hitframe < invincibilityframes)

#===CARRYING
@onready var hold_position : Node2D = $HoldPosition
@export var throw_speed : float = 100

#===ANIMATION
@onready var player_anim: AnimatedSprite2D = $PlayerAnim
@onready var item_anim: AnimationPlayer = $ItemsAnimations

#===ANIMATIONPOINTS
@onready var umbrella: Sprite2D = $HeadAnchor/Umbrella

#===STATE MACHINE
@onready var MyStateMachine = PlayerStateMachine.new(self)

#===INVENTORY
@onready var MyInventory : InventoryInfo = InventoryInfo.new(self)

func _ready() -> void:
	$PlayerAudio/AudioListener2D.make_current()
	MyStateMachine.Initialize(MyStateMachine.Move)
	item_anim.play("Idle_Umbrella")
	attack_anim.animation_finished.connect(_on_attack_animation_finished)
	finish_attack()

func _physics_process(delta: float) -> void:
	if isdead:
		return
	
	if bodies_of_water > 0:
		if not swim_audio.playing:
			swim_audio.play()
	else:
		swim_audio.stop()
	
	get_input()
	
	#god mode stuff
	if Input.is_action_just_pressed("god_mode"):
		activate_god_mode(not god_mode)
	
	MyStateMachine.Update(delta)
	if isdead:
		return
	
	update_side()
	item_animation()
	velocity = velo
	move_and_slide()
	
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

func start_attack() -> void:
	if is_attacking:
		return
	
	update_side()
	is_attacking = true
	attack_anim.play("Attack")
	attack_anim.advance(0)

func finish_attack():
	is_attacking = false
	#player_anim.offset.x = 0
	attack_anim.stop()
	attack_tentacle.hide()
	attack_hit_box.set_deferred("disabled", true)

func _on_attack_animation_finished(animation_name: StringName) -> void:
	if animation_name == &"Attack":
		finish_attack()

func update_side()-> void:
	if direction_x !=0:
		player_anim.flip_h = direction_x < 0
	
	arm_anchor.scale = Vector2(-1 if player_anim.flip_h else 1, 1)

func play_hit_animation() -> void:
	if ishurt or isdead:
		return
	
	ishurt = true
	player_anim.play("HitDamage")
	await player_anim.animation_finished
	ishurt = false
	
	if MyStateMachine.CurrentState == MyStateMachine.Swim:
		player_anim.play("Swimming")
#func _on_player_anim_animation_finished() -> void:
	#if player_anim.animation == "Attack":
		#player_anim.offset.x = 0
		#finish_attack()

func take_damage(type: int,amount:float, ignore_invincible: bool = false):
	# maybe i should make a static function to handle this globally and better? # if enemies take damage, yes - tbd
	if isdead or god_mode:
		return
		
	var was_hit = false
	if type % 2 == 1 && DmgLayer % 2 == 1 && !isinvincible():
		currentHP -= amount
		was_hit = true
	elif type % 4 == 2 && (DmgLayer - DmgLayer % 2) % 4 == 2 && !isinvincible():
		currentHP -= 2 * amount
		was_hit = true
	elif type % 8 == 4 && (DmgLayer - DmgLayer % 4) % 8 == 4:
		currentHP -= MaxHP * amount
		was_hit = true
	if was_hit:
		if not $PlayerAudio/Hit.playing:
			$PlayerAudio/Hit.play()
		# trigger vfx related to dmg
		if currentHP > 0 and not ignore_invincible:
			hitframe = Time.get_ticks_msec()
			$PlayerAnimations.play("Player_TakeDamage")
		
		HealthChanged.emit(currentHP,MaxHP)
		if currentHP > 0 and currentHP <= MaxHP * 0.33:
			$PlayerAnimations.play("Player_DmgThreshold")
		
		if currentHP <= 0:
			die()
		else:
			play_hit_animation()
	
	pass

func die():
	
	isdead = true
	swim_audio.stop()
	set_physics_process(false)
	
	finish_attack()
	player_anim.play("Death")
	await player_anim.animation_finished
	
	get_tree().change_scene_to_file("res://05_Scenes/_DemoScenes/LoseScene.tscn")

func change_water(entering:bool):
	liquid_counter.change_water(entering)
	#if entering:
		#bodies_of_water += 1
		#if bodies_of_water == 1:
			#MyStateMachine.ChangeState(MyStateMachine.Swim)
	#else:
		#bodies_of_water -= 1
		#if bodies_of_water == 0:
			#MyStateMachine.ChangeState(MyStateMachine.Fall)

func add_item(item:Item, index: int):
	MyInventory.AddItem(item,index)
	ItemCollected.emit(index,item)
	#inventoryUI.ChangeInventoryUI(index, item.tex)
	pass

func item_animation() -> void:
	umbrella.flip_h = false
	$HeadAnchor.scale.x = -1 if player_anim.flip_h else 1
	var animation_name = StringName(str(player_anim.animation) + "_Umbrella")
	if not item_anim.has_animation(animation_name):
		animation_name = &"Idle_Umbrella"
	
	if item_anim.assigned_animation != animation_name:
		item_anim.play(animation_name)

func activate_god_mode (enabled:bool) -> void:
	god_mode = enabled
	if god_mode:
		MyStateMachine.ChangeState(MyStateMachine.God)
	else:
		remove_god()

func remove_god() -> void:
	MyStateMachine.ChangeState(MyStateMachine.Fall)
