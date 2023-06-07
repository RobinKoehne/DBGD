extends Node2D

var treasureRoomOpen = false
var nextLevelOpen = false

@onready var tilemap = $Level
@onready var player = $Entities/Player
@onready var gatePlayer = $GatePlayer
var gateSound = preload("res://Scenes/gate.mp3")
var treasureCoordinates = [
	Vector2i(24,32),
	Vector2i(24,33),
	Vector2i(24,34),
]

var nextLevelCoordinates = [
	Vector2i(69,33),
	Vector2i(69,34),
]

var walkingSounds = [
	preload("res://sounds/FreeSteps/Tiles/Steps_tiles-001.ogg"),
	preload("res://sounds/FreeSteps/Tiles/Steps_tiles-002.ogg"),
	preload("res://sounds/FreeSteps/Tiles/Steps_tiles-002.ogg"),
	preload("res://sounds/FreeSteps/Tiles/Steps_tiles-002.ogg"),
	preload("res://sounds/FreeSteps/Tiles/Steps_tiles-003.ogg"),
	preload("res://sounds/FreeSteps/Tiles/Steps_tiles-004.ogg"),
	preload("res://sounds/FreeSteps/Tiles/Steps_tiles-005.ogg"),
	preload("res://sounds/FreeSteps/Tiles/Steps_tiles-003.ogg"),
	preload("res://sounds/FreeSteps/Tiles/Steps_tiles-003.ogg"),
	preload("res://sounds/FreeSteps/Tiles/Steps_tiles-003.ogg"),
	preload("res://sounds/FreeSteps/Tiles/Steps_tiles-001.ogg"),
	preload("res://sounds/FreeSteps/Tiles/Steps_tiles-005.ogg"),
	preload("res://sounds/FreeSteps/Tiles/Steps_tiles-005.ogg"),
	preload("res://sounds/FreeSteps/Tiles/Steps_tiles-005.ogg"),
	preload("res://sounds/FreeSteps/Tiles/Steps_tiles-003.ogg"),
	preload("res://sounds/FreeSteps/Tiles/Steps_tiles-001.ogg"),
	
]


# Called when the node enters the scene tree for the first time.
func _ready():
	var animation = $CanvasLayer2/AnimationPlayer
	var colorRect = $CanvasLayer2/ColorRect
	
	colorRect.show()
	animation.play("TransOut")
	await animation.animation_finished
	colorRect.hide
	gatePlayer.stream = gateSound
	pass
	player.walkingSounds = walkingSounds


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (get_node_or_null("Entities/Enemy_treasure") == null):
		openTreasureRoom()
	if (get_node_or_null("Entities/Boss") == null):
		openNextLevel()
	
	
func openTreasureRoom():
	if (treasureRoomOpen):
		return
	treasureRoomOpen = true
	for coord in treasureCoordinates:
		tilemap.set_cell(0, coord, 0, Vector2i(4, 0))
	gatePlayer.play()
	

func openNextLevel():
	if (nextLevelOpen):
		return
	nextLevelOpen = true
	for coord in nextLevelCoordinates:
		tilemap.set_cell(0, coord, 0, Vector2i(4, 0))
	gatePlayer.play()
