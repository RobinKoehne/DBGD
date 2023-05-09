class_name HurtBox
extends Area2D

@export_enum("Cooldown", "Hit", "DisableHitBox") var HurtBoxType = 0

@onready var collision = $CollisionShape2D
@onready var timer = $Timer

signal hurt(damage)

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
			emit_signal("hurt", damage)

func _on_timer_timeout():
	collision.set_deferred("disabled", false)

#func _init():
#	collision_layer = 0
#	collision_mask = 2

#func _ready():
#	area_entered.connect(self._on_area_entered())

#func _on_area_entered(hitbox: HitBox):
#	if hitbox == null:
#		return
#
#	if owner.has_method("take_damage"):
#		owner.take_damage(hitbox.damage )
