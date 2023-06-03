extends CharacterBody2D

@onready var animation_player = $AnimationPlayer
@onready var sprite = $Enemy1
@onready var timer = $Timer
@onready var stats = $Stats

enum{
	IDLE,
	change_dir,
	Move	
}

var speed = 30
var current_state = IDLE
var dir = Vector2.RIGHT
var knockback = Vector2.ZERO

func _ready():
	animation_player.play("Stand")
	randomize()

func choose_direction(array):
	array.shuffle()
	return array.front()
	
func _process(delta):
	match current_state:
		IDLE:
			pass
		change_dir:
			dir = choose_direction([Vector2.RIGHT, Vector2.LEFT, Vector2.UP, Vector2.DOWN])
		Move:
			if dir.x < 0:
				sprite.flip_h = 1
			else: 
				sprite.flip_h = 0
			velocity = dir * speed
			move_and_slide()

func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, 500 * delta)
	velocity = knockback
	move_and_slide()

func _on_timer_timeout():
	$Timer.wait_time = choose_direction([0.5, 1, 1.5])
	current_state = choose_direction([IDLE, change_dir, Move])

func _on_hurtbox_hurt(received_damage, area):
	knockback = area.knockback_vector * 210
	stats.health -= received_damage
	if stats.health <= 0:
		queue_free()
	print("Enemy took", received_damage, " damage, total health:", stats.health)

