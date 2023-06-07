extends Control

@onready var fullHearts = $FullHearts
@onready var halfHearts = $HalfHearts
@onready var shield = $Shield
@onready var playerStats: PlayerStats = get_tree().root.get_node("PlayerStats")

func _process(delta):
	calcHealth()
	

func calcHealth():
	if fullHearts != null:
		if playerStats.currentHealth == 0:
			halfHearts.visible = false
		elif floor(playerStats.currentHealth/2) == 0:
			fullHearts.visible = false
		else:
			fullHearts.size.x = floor(playerStats.currentHealth/2) * 16
			halfHearts.size.x = floor((playerStats.currentHealth+1)/2) * 16

func _on_player_stats_defend_changed(value):
	shield.visible = !shield.visible
