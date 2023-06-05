class_name HurtBox
extends Area2D

@export_enum("Cooldown", "Hit", "DisableHitBox") var HurtBoxType = 0

@onready var collision = $CollisionShape2D
@onready var timer = $Timer

signal hurt(damage)
signal heal()
signal defend()
signal speed()

func _on_area_entered(area):
	if area.is_in_group("attack"):
		if area.get("damage") != null:
			if HurtBoxType == 0:
				collision.set_deferred("disabled", true)
				timer.start()
			elif HurtBoxType == 1:
				pass
			elif HurtBoxType == 2:
				if area.has_method("tempdisable"):
					area.tempdisable()
			var damage = area.damage
			emit_signal("hurt", damage, area)
	
	elif area.is_in_group("items"):
		if area.get("effect") != null:
			if area.get("effect") == "heal":
				emit_signal("heal")
			
			elif area.get("effect") == "defend":
				emit_signal("defend")
			
			elif area.get("effect") == "speed":
				emit_signal("speed")

func _on_timer_timeout():
	collision.set_deferred("disabled", false)
