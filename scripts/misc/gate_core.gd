extends CharacterBody2D

var health = 1

var bullet = preload("res://scenes/misc/deathspark.tscn")


func _physics_process(delta):
	
	if health <= 0:
		queue_free()

func _damaged(dam):
	var inst = bullet.instantiate()
	get_tree().current_scene.add_child(inst)
	inst.global_position = global_position
	health -= dam

