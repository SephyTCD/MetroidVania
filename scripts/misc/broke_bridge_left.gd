extends CharacterBody2D


var gravity = 1800


func _physics_process(delta):

	velocity.y += gravity * delta

	move_and_slide()
