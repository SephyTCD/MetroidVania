extends CharacterBody2D

func _physics_process(delta):


	move_and_slide()



func _on_area_2d_body_entered(body):
	if body.has_method("_glide"):
		body._glide()
		queue_free()
