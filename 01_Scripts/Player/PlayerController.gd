extends CharacterBody2D

# Created from basic PlayerController script. To be modified.
# Player should: walk, attack, jump, climb ladders
# Extend later if theres time: swim, be launched?, dash, pogo?

#===MOVEMENT
@export var speed: float = 300
@export var acceleration: float = 1800
@export var friction: float = 500
@export var sprint_mult: float = 1.5
var direction_x : float
var current_speed : float

#===JUMP
@export var jump_height : float = 100
@export var jump_time_full_up : float = 0.5
@export var jump_time_down : float = 0.4

@onready var jump_velocity: float = -(2.0 * jump_height) / jump_time_full_up
@onready var jump_gravity: float = (2.0 * jump_height) / (jump_time_full_up * jump_time_full_up)
@onready var fall_gravity: float = (2.0 * jump_height) / (jump_time_full_up * jump_time_down)

#===ATTACK
@onready var attack_hit_box: CollisionShape2D = $AttackHitBox/HitBox
@onready var attack_collision: Area2D = $AttackHitBox
@export var attack_offset: float = 16
var is_attacking: bool = false

#===ANIMATION
@onready var player_anim: AnimatedSprite2D = $PlayerAnim #the $ is godots shortway of references. Also drag from scene tab into script

func _physics_process(delta: float) -> void:
	get_input()
	move(delta)
	update_animation(direction_x)
	move_and_slide() #this is what is actually performing the movement
	
func get_input():
	direction_x = Input.get_axis("move_left", "move_right")
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity
	
	if Input.is_action_pressed("sprint"):
		current_speed = speed * sprint_mult
	
	if Input.is_action_just_pressed("attack") and !is_attacking:
		start_attack()

func move(delta):
	if direction_x:
		velocity.x = move_toward(velocity.x, direction_x * speed, acceleration * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, friction * delta)
	if not is_on_floor():
		velocity.y += get_custom_gravity() * delta

func get_custom_gravity():
	if velocity.y < 0.0:
		return jump_gravity
	else:
		return fall_gravity

func start_attack():
	is_attacking = true
	player_anim.play("Attack")
	attack_hit_box.set_deferred("disabled", false)

func finish_attack():
	is_attacking = false
	attack_hit_box.set_deferred("disabled", true)
	
func update_animation(direction: float) -> void:
	
	if is_attacking:
		return
	if direction != 0:
		player_anim.flip_h = direction > 0 #built in flip horizontal and vertical (v)
		attack_collision.position.x = direction * attack_offset
	if not is_on_floor():
		player_anim.play("Jump")
	elif direction != 0: #elif if inbetween if and else > serves as "otherwise if"
		player_anim.play("Walk")
	else:
		player_anim.play("Idle")

func _on_player_anim_animation_finished() -> void:
	if player_anim.animation == "Attack":
		finish_attack()
