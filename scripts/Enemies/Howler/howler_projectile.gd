extends CharacterBody2D
class_name howler_projectile

var speed = 500.0
var time = .60
var damage = 1
var direction = 1
var soundAble = 0
var knockForce = 200
var knockUp = -200

@onready var animations : AnimationPlayer = $AnimationPlayer
@onready var sprite : Sprite2D = $Sprite2D

func _physics_process(delta):
	if (Globals.checkForCutsceneFreeze()): # freeze if in cutscene
		return
	
	time -= delta
	if time <= 0:
		queue_free()

	velocity.x = speed

	if velocity.x > 0:
		sprite.flip_h = true
	if velocity.x < 0:
		sprite.flip_h = false

	animations.play("pulse")

	move_and_slide()

func _on_area_2d_body_entered(body):
	if body.has_method("_damaged"):
		body._damaged(damage, direction * -1, knockForce, knockUp)
