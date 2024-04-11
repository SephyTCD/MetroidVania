extends CharacterBody2D

var heal = 2

func _physics_process(delta):
	pass


func _on_area_2d_body_entered(body):
	if body.has_method("_heal"):
		body._heal(heal)
	queue_free()
