extends CharacterBody2D

var health = 1


func _physics_process(delta):
	
	if health <= 0:
		queue_free()

func _damaged(dam):
	health -= dam
