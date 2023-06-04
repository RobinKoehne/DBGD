extends Control

var max_health = 6
var health = 6 : set = set_health

@onready var fullHearts = $FullHearts
@onready var halfHearts = $HalfHearts
@onready var shield = $Shield

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

func _on_player_stats_defend_changed(value):
	shield.visible = !shield.visible
