extends CanvasLayer


const main = preload("res://Scenes/landing_scene.tscn")
const map1 = preload("res://Scenes/Map1.tscn")

func _ready():
	get_node("ColorRect").hide()
	get_node("Label").hide()
	
func changeState(path):
	get_node("ColorRect").show()
	get_node("Label").hide()
	get_node("AnimationPlayer").play("TransIn")
	await get_node("AnimationPlayer").animation_finished
	
	var stage = path.instantiate()
	get_tree().get_root().get_node("Node2D").free()
	get_tree().get_root().add_child(stage)
	
	
	get_node("AnimationPlayer").play("TransOut")
	await get_node("AnimationPlayer").animation_finished
	get_node("ColorRect").hide()
