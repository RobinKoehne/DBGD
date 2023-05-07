extends CharacterBody2D

@export var speed = 150

func _ready():
	$AnimationPlayer.play("Stand")

func _physics_process(delta):
	velocity = Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	)
	
	velocity *= speed
	
	move_and_slide()
	
	if Input.is_action_pressed("ui_left"):
		$Player.flip_h = 1
		$AnimationPlayer.play("Walk")
	elif Input.is_action_pressed("ui_right") or Input.is_action_pressed("ui_down") or Input.is_action_pressed("ui_up"):
		$Player.flip_h = 0
		$AnimationPlayer.play("Walk")
	elif Input.is_action_just_released("ui_right") or Input.is_action_just_released("ui_down") or Input.is_action_just_released("ui_up"):
		$Player.flip_h = 0
		$AnimationPlayer.play("Stand")
	elif Input.is_action_just_released("ui_left"):
		$Player.flip_h = 1
		$AnimationPlayer.play("Stand")


