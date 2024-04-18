extends CharacterBody2D

var flicker = preload("res://scenes/misc/absflicker.tscn")


func _physics_process(delta):
	pass


func _on_area_2d_body_entered(body):
	if body.has_method("_maxup"):
		body._maxup()
		var inst = flicker.instantiate()
		get_tree().current_scene.add_child(inst)
		inst.global_position = global_position
		queue_free()
