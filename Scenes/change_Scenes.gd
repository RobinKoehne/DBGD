extends Area2D

var entered = false

var killed_enemies = 0

func _on_body_entered(body: PhysicsBody2D):
	entered = true
	


func _on_body_exited(body):
	entered = false
	

func _process(delta):
	if killed_enemies == 3:
		killed_enemies = 0
		StageManager.changeState(StageManager.map1)



func _on_animated_enemy_1_killed():
	killed_enemies += 1


func _on_animated_enemy_2_killed():
	killed_enemies += 1


func _on_animated_enemy_3_killed():
	killed_enemies += 1
