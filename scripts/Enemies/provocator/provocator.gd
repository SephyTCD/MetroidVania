extends CharacterBody2D
class_name Provocator

var direction = 1
var transTime = 0
var aim = 0
var damage = 1
var health = 6
var boxTime = 0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animations : AnimationPlayer = $AnimationPlayer
@onready var sprite : Sprite2D = $Sprite2D

func _physics_process(_delta):
	if (Globals.checkForCutsceneFreeze()): # freeze if in cutscene
		return

	if health <= 0:
		queue_free()

	if boxTime > 0:
		boxTime -= _delta
		$Area2D/CollisionShape2D.disabled = true
	else:
		$Area2D/CollisionShape2D.disabled = false

	if direction == 1:
		$Marker2D.position.x = abs($Marker2D.position.x) * 1
	if direction == -1:
		$Marker2D.position.x = abs($Marker2D.position.x) * -1

	velocity.y = gravity * _delta

	move_and_slide()

func _on_area_2d_body_entered(body):
	if body.has_method("_damaged"):
		body._damaged(damage, direction)
		boxTime = .01

func _damaged(dam):
	health -= dam

