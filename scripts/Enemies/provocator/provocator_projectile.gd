extends CharacterBody2D
class_name provocator_projectile

var direction = -1
var speed = 375.0
var time = .8
var damage = 1

func _physics_process(delta):
	if (Globals.checkForCutsceneFreeze()): # freeze if in cutscene
		return
	
	time -= delta
	if time <= 0:
		
		queue_free()

	move_and_slide()

func _on_area_2d_body_entered(body):
	if body.has_method("_damaged"):
		body._damaged(damage, direction)
	queue_free()
