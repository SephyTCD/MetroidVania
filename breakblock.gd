extends CharacterBody2D

func _physics_process(delta):

	move_and_slide()

func _crush():
	queue_free()
