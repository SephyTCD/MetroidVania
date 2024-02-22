extends CharacterBody2D

var speed = 300.0
var time = 0.60
var damage = 15

func _physics_process(delta):
	time -= delta
	if time <= 0:
		queue_free()
		
	move_and_slide()
	
	
func _on_area_2d_body_entered(body):
	if body.has_method("_take_damage"):
		body._take_damage(damage)
	queue_free()
