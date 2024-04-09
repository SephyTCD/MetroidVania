extends CharacterBody2D
class_name Perfuit

var speed = 40.0
var jumpSpeed = -200
var direction = 1
var transTime = 0
var damage = 1
var health = 4
var boxTime = 0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animations : AnimationPlayer = $AnimationPlayer
@onready var sprite : Sprite2D = $Sprite2D

func _physics_process(_delta):

	if health <= 0:
		queue_free()

	if boxTime > 0:
		boxTime -= _delta
		$Area2D/CollisionShape2D.disabled = true
	else:
		$Area2D/CollisionShape2D.disabled = false

	velocity.y += gravity * _delta
	velocity.x = direction * speed

	move_and_slide()

func _on_area_2d_body_entered(body):
	if body.has_method("_damaged"):
		body._damaged(damage, direction)
		boxTime = .01

func _damaged(dam):
	health -= dam

