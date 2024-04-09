extends CharacterBody2D
class_name Wanderer

var health = 10
var speed = 0
var direction = 1
var damage = 2
var boxTime = 0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animations : AnimationPlayer = $AnimationPlayer
@onready var sprite : Sprite2D = $Sprite2D

func _physics_process(_delta):

	if health <= 0:
		queue_free()

	if health == 0:
		queue_free()

	velocity.y += gravity * _delta
	velocity.x = direction * speed

	if boxTime > 0:
		boxTime -= _delta
		$body_hitbox/CollisionPolygon2D.disabled = true
	else:
		$body_hitbox/CollisionPolygon2D.disabled = false

	if direction == 1:
		$body_hitbox.scale.x = -1
		$CollisionShape2D.scale.x = -1
		$swing_hitbox.scale.x = -1
	if direction == -1:
		$body_hitbox.scale.x = 1
		$CollisionShape2D.scale.x = 1
		$swing_hitbox.scale.x = 1

	move_and_slide()


func _on_body_hitbox_body_entered(body):
	if body.has_method("_damaged"):
		body._damaged(damage, direction)
		boxTime = .01

func _on_swing_hitbox_body_entered(body):
	if body.has_method("_damaged"):
		body._damaged(damage, direction)

func _damaged(dam):
	health -= dam

