extends Area2D

var animated_sprite: AnimatedSprite2D
var playerInRange = false
var isOpen = false

func _on_Area2D_body_entered(body):
	print("Player in range")
	playerInRange = true

func _on_Area2D_body_exited(body):
	print("Player not in range")
	playerInRange = false

# Called when the node enters the scene tree for the first time.
func _ready():
	animated_sprite = $AnimatedSprite2D
	connect("body_entered", _on_Area2D_body_entered, CONNECT_PERSIST)
	connect("body_exited", _on_Area2D_body_exited, CONNECT_PERSIST)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if isOpen:
		return
	
	if Input.is_action_just_pressed("ui_accept") and playerInRange == true:
		animated_sprite.play("open")
		isOpen = true
		emit_signal("opened")  # Emit the "opened" signal

