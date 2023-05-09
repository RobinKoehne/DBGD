class_name HitBox
extends Area2D

var damage

@onready var collision = $CollisionShape2D
@onready var timer = $Timer

func tempdisable():
	collision.set_deferred("disabled", true)
	timer.start()

func _on_timer_timeout():
	collision.set_deferred("disabled", false)
	
func _enter_tree():
	damage = get_parent().damage
