extends CharacterBody2D

var turn = 0
var turnTrig = 1
var shot = preload("res://hunter_projectile.tscn")
var target = null
var attackTrig = 0
var health = 5

func _physics_process(delta):

	if health == 0:
		queue_free()

	if turnTrig == 1:
		_on_timer_timeout()
		turnTrig = 0

	move_and_slide()

func _on_timer_timeout():
	_fly()

func _fly():
	if turn == 0:
		velocity.x = 200
		turn = 1
		return
	if turn == 1:
		velocity.x = -200
		turn = 0

func _on_attack_timer_timeout():
	if target != null:
		_shoot()

func _on_site_body_entered(body):
	if body.name == "Player":
		target = body

func _on_site_body_exited(body):
	if body.name == "Player":
		target = null

func _shoot():
	var inst = shot.instantiate()
	get_parent().add_child(inst)
	inst.global_position = $Marker2D.global_position
	inst.velocity = (target.global_position - inst.global_position).normalized() * inst.speed

func _take_damage(damageAmount):
	health = health - damageAmount
