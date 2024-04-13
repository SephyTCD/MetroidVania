extends CharacterBody2D
class_name Canis

var speed = 300.0
var jumpSpeed = -500
var direction = 1
var damage = 2
var boxTime = 0

var health = 60

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var marker = $Marker2D

@onready var animations : AnimationPlayer = $AnimationPlayer
@onready var sprite : Sprite2D = $Sprite2D

func _physics_process(_delta):
	
	if health <= 0:
		queue_free()

	velocity.y += gravity * _delta

	if boxTime > 0:
		boxTime -= _delta
		$Area2D/CollisionPolygon2D.disabled = true
	else:
		$Area2D/CollisionPolygon2D.disabled = false

		if direction < 0:
			$Marker2D.position.x = abs($Marker2D.position.x) * -1

		if direction > 0:
			$Marker2D.position.x = abs($Marker2D.position.x) * 1

	move_and_slide()

func _damaged(dam):
	health -= dam

func _on_area_2d_body_entered(body):
	if body.has_method("_damaged"):
		body._damaged(damage, direction)
		boxTime = .01
