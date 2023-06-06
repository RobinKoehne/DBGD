extends CharacterBody2D

@onready var animation_player = $AnimationPlayer
@onready var sprite = $Player
@onready var sword_sprite = $Sword/Sprite2D
@onready var sword_hitbox = $Sword/Hitbox
@onready var sword = $Sword
@onready var stats = $PlayerStats
@onready var swordPlayer = $SwordPlayer
@onready var walkingPlayer = $WalkPlayer

var MAX_SPEED = 200
const ACCELERATION = 3000
const FRICTION = 2000

var isAttacking = false
var isPlayingWalkingSound = false

var attackSounds = [
	preload("res://sounds/battle/swing.wav"),
	preload("res://sounds/battle/swing2.wav"),
	preload("res://sounds/battle/swing3.wav"),
]

var walkingSounds = [
	preload("res://sounds/FreeSteps/Dirt/Steps_dirt-001.ogg"),
	preload("res://sounds/FreeSteps/Dirt/Steps_dirt-001.ogg"),
	preload("res://sounds/FreeSteps/Dirt/Steps_dirt-001.ogg"),
	preload("res://sounds/FreeSteps/Dirt/Steps_dirt-001.ogg"),
	preload("res://sounds/FreeSteps/Dirt/Steps_dirt-001.ogg"),
	preload("res://sounds/FreeSteps/Dirt/Steps_dirt-002.ogg"),
	preload("res://sounds/FreeSteps/Dirt/Steps_dirt-003.ogg"),
	preload("res://sounds/FreeSteps/Dirt/Steps_dirt-004.ogg"),
	preload("res://sounds/FreeSteps/Dirt/Steps_dirt-005.ogg"),
	preload("res://sounds/FreeSteps/Dirt/Steps_dirt-006.ogg"),
]

enum {MOVE, ATTACK, HIT}

var state = MOVE
var old_velocity = Vector2.ZERO


func _ready():
	animation_player.play("Stand")
	sword.hide()
	walkingSounds.shuffle()
	
func _process(_delta):
	isPlayingWalkingSound = walkingPlayer.playing

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
		play_walking_sound()
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
		if (animation_player.current_animation != "Hit"):
			animation_player.play("Walk")
	elif input_vector.x >= 0:
		sword_hitbox.knockback_vector.x = 1
		sprite.flip_h = 0
		var old = sword_sprite.flip_v
		sword_sprite.flip_v = 0
		if (old != sword_sprite.flip_v):
			sword_sprite.move_local_y(-45)
			sword_hitbox.move_local_y(-45)
		if (animation_player.current_animation != "Hit"):
			animation_player.play("Walk")
	elif input_vector == Vector2.ZERO:
		if (animation_player.current_animation != "Hit"):
			animation_player.play("Walk")
	
	if Input.is_action_just_pressed("attack"):
		state = ATTACK

func attack_state():
	if (isAttacking):
		return
	if (sword.get_parent() != null):
		isAttacking = true
		sword.show()
		animation_player.play("Attack")
		_playAttackSound()
	
func attack_animation_finished():
	sword.hide()
	state = MOVE
	isAttacking = false

func hit_state():
	animation_player.play("Hit")
	state = MOVE
	
func play_walking_sound():
	if(isPlayingWalkingSound):
		return
	var soundIndex = randi_range(0, walkingSounds.size() - 1)
	var sound = walkingSounds[soundIndex]
	walkingPlayer.stream = sound;
	walkingPlayer.play()
	isPlayingWalkingSound = true

func _on_hurtbox_hurt(damage, area):
	if stats.defend:
		stats.defend = false
	else:
		stats.health -= damage
		if stats.health <= 0:
			get_tree().change_scene_to_file("res://Scenes/game_over_screen.tscn")
		state = HIT

func _on_hurtbox_heal():
	stats.health += 1

func _on_hurtbox_defend():
	stats.defend = true

func _on_hurtbox_speed():
	stats.speed = true
	stats.speedTimer.start()

func _on_player_stats_speed_changed(value):
	if value == true:
		MAX_SPEED = 300
	else:
		MAX_SPEED = 200

func _on_speed_timer_timeout():
	stats.speed = false

func _playAttackSound():
	var soundIndex = randi_range(0, 2)
	var sound = attackSounds[soundIndex]
	swordPlayer.stream = sound
	swordPlayer.play()
