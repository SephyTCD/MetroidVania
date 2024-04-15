extends CharacterBody2D
class_name Canis_Projectile

var direction = 1
var speed = 50.0
var time = 10
var damage = 2

@onready var animations : AnimationPlayer = $AnimationPlayer
@onready var sprite : Sprite2D = $Sprite2D

func _physics_process(_delta):
	
	time -= _delta
	if time <= 0:
		queue_free()

	velocity.x = speed

	if velocity.x > 0:
		animations.play("pulse")
		sprite.flip_h = true
	if velocity.x < 0:
		animations.play("pulse")
		sprite.flip_h = false

	move_and_slide()

func _on_area_2d_body_entered(body):
	if body.has_method("_damaged"):
		body._damaged(damage, direction * -1)
	queue_free()
