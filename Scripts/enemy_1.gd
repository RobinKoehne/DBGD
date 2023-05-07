extends CharacterBody2D

enum{
	IDLE,
	change_dir,
	Move	
}

var speed = 30
var current_state = IDLE
var dir = Vector2.RIGHT

func _ready():
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
			dir = choose_direction([Vector2.RIGHT, Vector2.LEFT, Vector2.UP, Vector2.DOWN])
		Move:
			move(delta)
			
			

func _on_timer_timeout():
	$Timer.wait_time = choose_direction([0.5, 1, 1.5])
	current_state = choose_direction([IDLE, change_dir, Move])
