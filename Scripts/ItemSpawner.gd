extends Area2D

@onready var player = $Player
@onready var chestPlayer = $ChestSound

var animated_sprite: AnimatedSprite2D
var playerInRange = false
var isOpen = false
var items = [
	preload("res://Items/red_potion.tscn"),
	preload("res://Items/yellow_potion.tscn"),
	preload("res://Items/green_potion.tscn"),
	#preload("res://Items/sword_1.tscn"),
	#preload("res://Items/sword_2.tscn"),
	#preload("res://Items/sword_3.tscn"),
	#preload("res://Items/axe_1.tscn"),
	#preload("res://Items/axe_2.tscn"),
	#preload("res://Items/axe_3.tscn"),
	#preload("res://Items/battleaxe_1.tscn"),
	#preload("res://Items/battleaxe_2.tscn"),
	#preload("res://Items/battleaxe_3.tscn")
]

var itemRadius = 50

func _on_Area2D_body_entered(body):
	print("Player in range")
	playerInRange = true

func _on_Area2D_body_exited(body):
	print("Player not in range")
	playerInRange = false

func _ready():
	animated_sprite = $AnimatedSprite2D
	connect("body_entered", _on_Area2D_body_entered, CONNECT_PERSIST)
	connect("body_exited", _on_Area2D_body_exited, CONNECT_PERSIST)

func _process(delta):
	if isOpen:
		return
	
	if Input.is_action_just_pressed("ui_accept") and playerInRange:
		animated_sprite.play("open")
		chestPlayer.play()
		spawnItems()
		isOpen = true

func spawnItems():
	var itemAmount = randi() % 3 + 1 # Random item Amount between 1 and 4
	var angleStep = 90.0 / itemAmount
	var angleOffset = 60	

	for i in range(itemAmount):
		var item = randomItem()
		var itemInstance = item.instantiate()
		if itemInstance:
			get_parent().add_child(itemInstance)
			var angle = deg_to_rad(i * angleStep + angleOffset)
			var itemPosition = Vector2(cos(angle), -sin(angle)) * itemRadius
			itemInstance.position = itemPosition
		else:
			print("Failed to instance the item scene")

func randomItem(): 
	items.shuffle()
	return items.front()
