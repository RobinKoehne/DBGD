extends Area2D

var effect = "sword3"

func _on_area_entered(area):
	if (area.is_in_group("player")):
		queue_free()
