extends CharacterBody2D
class_name Projectile

var direction = 1
var speed = 500.0
var time = .35
var damage = 1

@onready var animations : AnimationPlayer = $AnimationPlayer
@onready var sprite : Sprite2D = $Sprite2D

func _physics_process(_delta):
	
	time -= _delta
	if time <= 0:
		queue_free()
	
	if direction > 0:
		animations.play("spin")
		sprite.flip_h = false
	if direction < 0:
		animations.play("spin")
		sprite.flip_h = false
	
	direction = Input.get_axis("ui_left", "ui_right")
	
	velocity.x = speed

	move_and_slide()

func _on_area_2d_body_entered(body):
	if body.has_method("_damaged"):
		body._damaged(damage)
	queue_free()
