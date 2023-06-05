extends Area2D

var entered = false
func _on_body_entered(body: PhysicsBody2D):
	entered = true
	


func _on_body_exited(body):
	entered = false
	

func _process(delta):
	if entered == true:
		if Input.is_action_just_pressed("switch_scene"):
			StageManager.changeState(StageManager.map1)

