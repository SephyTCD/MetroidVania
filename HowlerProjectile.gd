extends CharacterBody2D
class_name HowlerProjectile

var speed = 500.0
var time = .35

func _physics_process(delta):
	time -= delta
	if time <= 0:
		queue_free()

	velocity.x = speed

	move_and_slide()
