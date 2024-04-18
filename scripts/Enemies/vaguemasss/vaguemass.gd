extends CharacterBody2D
class_name Mass

var time = 7
var speed = 180
var direction = 1
var damage = 0
var boxTime = 0
var knockBack = 1000
var knockForce = -500

@onready var animations : AnimationPlayer = $AnimationPlayer

func _physics_process(_delta):

	animations.play("pulse")

	if boxTime > 0:
		boxTime -= _delta
		$Area2D/CollisionShape2D.disabled = true
	else:
		$Area2D/CollisionShape2D.disabled = false

		time -= _delta

	velocity.x = speed * direction

	if time <= 0:
		direction = -1
		speed = 50

	if time < -15:
		queue_free()

	move_and_slide()


func _on_area_2d_body_entered(body):
	if body.has_method("_damaged"):
		body._damaged(damage, direction, knockBack, knockForce)
		boxTime = .01
