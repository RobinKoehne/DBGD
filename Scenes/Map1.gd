extends Node2D

var treasureRoomOpen = false
var nextLevelOpen = false
@onready var tilemap = $Level
@onready var player = $Entities/Player
var treasureCoordinates = [
	Vector2i(24,32),
	Vector2i(24,33),
	Vector2i(24,34),
]

var nextLevelCoordinates = [
	Vector2i(69,33),
	Vector2i(69,34),
]


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


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
	

func openNextLevel():
	if (nextLevelOpen):
		return
	nextLevelOpen = true
	for coord in nextLevelCoordinates:
		tilemap.set_cell(0, coord, 0, Vector2i(4, 0))
