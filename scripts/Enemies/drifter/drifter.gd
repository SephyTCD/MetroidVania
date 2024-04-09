extends CharacterBody2D
class_name Drifter

var speed = 0
var direction = 1
var damage = 1
var health = 6
var boxTime = 0

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

	if direction == -1:
		animations.play("drifter_wave")
		sprite.flip_h = false
	if direction == 1:
		animations.play("drifter_wave")
		sprite.flip_h = true

	move_and_slide()


func _on_area_2d_body_entered(body):
	if body.has_method("_damaged"):
		body._damaged(damage, direction)
		boxTime = .01

func _damaged(dam):
	health -= dam

