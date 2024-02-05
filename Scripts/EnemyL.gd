extends CharacterBody2D

var speed = 32
var target = null
func _ready():
	pass
	
func _process(_delta):
	if target:
		speed = 32
		_physics_process(_delta)
		
func _on_site_body_entered(body):
	if body.name == "Player":
		target = body
		print("check2")
		
func _on_site_body_exited(body):
	if body.player == "Player":
		target = null 
		print("check3")
		
func _physics_process(delta):
	if target:
		velocity = global_position.direction_to(target.global_position)
		move_and_collide(velocity * speed * delta)
		print("check4")
		
		
