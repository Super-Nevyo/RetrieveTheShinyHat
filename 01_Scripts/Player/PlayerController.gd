extends CharacterBody2D

# Created from basic PlayerController script. To be modified.
# Player should: walk, attack, jump, climb ladders
# Extend later if theres time: swim, be launched?, dash, pogo?

#===MOVEMENT
@export var speed: float = 300
@export var jump_velocity: float = -300
@export var acceleration: float = 1800
@export var deceleration: float = 1800
@export var sprint_mult: float = 1.5

#===ATTACK
var is_attacking: bool = false

#===ANIMATION
@onready var player_anim: AnimatedSprite2D = $PlayerAnim #the $ is godots shortway of references. Also drag from scene tab into script
@onready var attack_hit_box: CollisionShape2D = $AttackHitBox/HitBox

func _physics_process(delta: float) -> void: #function needed always to handle physics in godot. Like Fixed Update in unity
	#delta controls how much time has passed since the last phys update (time delta time)
	
	if not is_on_floor():
		velocity += get_gravity() * delta #so i need to assign what is floor so this auto detects. Its not by layers or tags!!

	# Handle jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity
	
	# Handle float maybe in the future but essentially is without "just" on the func
	if Input.is_action_pressed("jump"):
		velocity.y = jump_velocity

	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("move_left", "move_right")
	var current_speed := speed
	
	if Input.is_action_pressed("sprint"):
		current_speed = speed * sprint_mult
	
	if Input.is_action_pressed("attack"):
		start_attack()
	
	update_animation(direction)

	if direction:
		velocity.x = move_toward(
			velocity.x, direction * current_speed, acceleration * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, deceleration * delta)

	move_and_slide() #this is what is actually performing the movement

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

	if not is_on_floor():
		player_anim.play("Jump")
	elif direction != 0: #elif if inbetween if and else > serves as "otherwise if"
		player_anim.play("Walk")
	else:
		player_anim.play("Idle")


func _on_player_anim_animation_finished() -> void:
	if player_anim.animation == "Attack":
		finish_attack()
