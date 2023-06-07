extends CanvasLayer


@onready var playerStats: PlayerStats = get_tree().root.get_node("PlayerStats")

func _ready():
	playerStats.currentHealth = 6


func _on_restart_pressed():
	get_tree().change_scene_to_file("res://Scenes/landing_scene.tscn")


func _on_quit_pressed():
	get_tree().quit()
