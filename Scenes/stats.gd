extends Node

signal health_changed(value)
signal defend_changed(value)

@export var max_health = 6
@export var health = 6 : set = set_health
@export var damage = 1
@export var defend = false : set = set_defend

func set_health(value):
	if value <= max_health:
		health = value
		emit_signal("health_changed", health)

func set_defend(value):
	defend = value
	emit_signal("defend_changed", value)
