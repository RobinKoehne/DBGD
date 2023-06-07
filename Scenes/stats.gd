extends Node

signal health_changed(value)
signal defend_changed(value)
signal speed_changed(value)

@export var max_health = 6
@export var health = 6 : set = set_health
@export var damage = 1
@export var defend = false : set = set_defend
@export var speed = false : set = set_speed
@onready var speedTimer = $SpeedTimer
@onready var playerStats: PlayerStats = get_tree().root.get_node("PlayerStats")

func _ready():
	if get_parent().name == "Player":
		var speedTimer = $SpeedTimer

func set_health(value):
	health = value
	if value <= health:
		emit_signal("health_changed", value)

func set_defend(value):
	defend = value
	emit_signal("defend_changed", value)

func set_speed(value):
	speed = value
	emit_signal("speed_changed", value)
