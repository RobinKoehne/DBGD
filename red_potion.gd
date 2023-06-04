extends Area2D

var effect = "heal"

func _on_area_entered(area):
	queue_free()
