extends Area2D

var entered = false

var killed_enemies = 0
@onready var animation = $CanvasLayer/AnimationPlayer
@onready var colorRect = $CanvasLayer/ColorRect
@onready var sound = $levelChanged


func _on_body_entered(body: PhysicsBody2D):
	entered = true
	


func _on_body_exited(body):
	entered = false
	

func _process(delta):
	if killed_enemies == 3:
		killed_enemies = 0
		sound.play()
		colorRect.show()
		animation.play("TransIn")
		await animation.animation_finished
		colorRect.hide()
		get_tree().change_scene_to_file("res://Scenes/Map1.tscn")

	
func _on_animated_enemy_1_killed():
	killed_enemies += 1


func _on_animated_enemy_2_killed():
	killed_enemies += 1


func _on_animated_enemy_3_killed():
	killed_enemies += 1
