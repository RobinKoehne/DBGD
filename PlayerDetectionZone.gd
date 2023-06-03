extends Area2D

var player = null
var hasPlayer = false

func _on_body_entered(body):
	player = body
	hasPlayer = true

func _on_body_exited(body):
	player = null
	hasPlayer = false
