extends CharacterBody2D

enum{
	IDLE,
	change_dir,
	Move	
}

const speed = 30
var current_state = IDLE
var dir = Vector2.RIGHT
var knockback = Vector2.ZERO

func _ready():
	$Sprite2D.play("Idle")
	randomize()


func choose_direction(array):
	array.shuffle()
	return array.front()
	
func move(delta):
	position += dir * speed * delta
	
func _process(delta):
	match current_state:
		IDLE:
			pass
		change_dir:
			dir = choose_direction([Vector2.RIGHT,Vector2.LEFT,Vector2.UP,Vector2.DOWN])
		Move:
			move(delta)
			
			

func _on_timer_timeout():
	$Timer.wait_time = choose_direction([0.5, 1, 1.5])
	current_state = choose_direction([IDLE, change_dir, Move])

func _on_hurtbox_area_entered(area):
	knockback = Vector2.RIGHT * 100
	
func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, 2000 * delta)
	velocity.x = move_toward(knockback.x, 0, delta)
	velocity.y = move_toward(knockback.y, 0, delta)
