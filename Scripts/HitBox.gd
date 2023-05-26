class_name HitBox
extends Area2D

@onready var collision = $CollisionShape2D
@onready var timer = $Timer
@onready var stats
@onready var parent
@onready var damage

func _ready():
	parent = get_parent()
	if parent:
		stats = parent.get_node("Stats")
		if stats:
			damage = stats.damage

func tempdisable():
	collision.set_deferred("disabled", true)
	timer.start()

func _on_timer_timeout():
	collision.set_deferred("disabled", false)
