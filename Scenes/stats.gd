extends Node

signal health_changed(value)

@export var max_health = 6
@export var health = 6 : set = set_health
@export var damage = 1

func set_health(value):
	health = value
	emit_signal("health_changed", health)
