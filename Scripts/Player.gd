extends CharacterBody2D

@onready var animation_player = $AnimationPlayer
@onready var sprite = $Player
@onready var sword_sprite = $Sword/Sprite2D
@onready var sword_hitbox = $Sword/Hitbox
@onready var sword = $Sword
@onready var stats = $PlayerStats

#@onready var damage = stats.damage

const MAX_SPEED = 200
const ACCELERATION = 3000
const FRICTION = 2000

enum {MOVE, ATTACK, HIT}

var state = MOVE
var old_velocity = Vector2.ZERO

func _ready():
	animation_player.play("Stand")

func _physics_process(_delta):
	match state:
		MOVE:
			move_state(_delta)
		
		ATTACK:
			attack_state()
		
		HIT:
			hit_state()

func move_state(_delta):
	# Bewegung
	var input_vector = Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	).normalized()

	if input_vector != Vector2.ZERO:
		velocity = old_velocity + ACCELERATION * input_vector * _delta
		velocity = velocity.limit_length(MAX_SPEED)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * _delta)
	
	old_velocity = velocity
	
	move_and_slide()
	
	# Animation	
	if input_vector.x < 0:
		sword_hitbox.knockback_vector.x = -1
		sprite.flip_h = 1
		var old = sword_sprite.flip_v
		sword_sprite.flip_v = 1
		if (old != sword_sprite.flip_v):
			sword_sprite.move_local_y(45)
			sword_hitbox.move_local_y(45)
		animation_player.play("Walk")
	elif input_vector.x > 0:
		sword_hitbox.knockback_vector.x = 1
		sprite.flip_h = 0
		var old = sword_sprite.flip_v
		sword_sprite.flip_v = 0
		if (old != sword_sprite.flip_v):
			sword_sprite.move_local_y(-45)
			sword_hitbox.move_local_y(-45)
		animation_player.play("Walk")
	elif input_vector == Vector2.ZERO:
		animation_player.play("Stand")
	
	if Input.is_action_just_pressed("attack"):
		state = ATTACK

func attack_state():
	animation_player.play("Attack")
	
func attack_animation_finished():
	state = MOVE

func hit_state():
	animation_player.play("Hit")
	
func hit_animation_finished():
	state = MOVE

func _on_hurtbox_hurt(damage, area):
	print("Player took damage")
	stats.health -= damage
	if stats.health <= 0:
		print("Game Over")
	state = HIT
