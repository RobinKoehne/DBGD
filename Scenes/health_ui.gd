extends Control

var max_health = 6
var health = 6 : set = set_health

@onready var fullHearts = $FullHearts
@onready var halfHearts = $HalfHearts

func set_health(value):
	health = clamp(value, 0, max_health)
	if fullHearts != null:
		if health == 0:
			halfHearts.visible = false
		elif floor(health/2) == 0:
			fullHearts.visible = false
		else:
			fullHearts.size.x = floor(health/2) * 16
			halfHearts.size.x = floor((health+1)/2) * 16
