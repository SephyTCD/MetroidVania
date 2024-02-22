extends CharacterBody2D

var shot = preload("res://turret_projectile.tscn")
var target = null
@onready var animations : AnimationPlayer = $AnimationPlayer
@onready var sprite : Sprite2D = $Sprite2D


func _on_timer_timeout():
	if target != null:
		_shoot()

func _on_detect_body_entered(body):
	if body.name == "Player":
		target = body
	
	
func _on_detect_body_exited(body):
	animations.play("Idle")
	if body.name == "Player":
		target = null
		
	
func _shoot():
	var inst = shot.instantiate()
	get_parent().add_child(inst)
	inst.global_position = $Marker2D.global_position
	inst.velocity = (target.global_position - inst.global_position).normalized() * inst.speed
	animations.play("Shoot")
	
	



