extends CharacterBody2D
class_name Perfuit

var speed = 40.0
var jumpSpeed = -200
var direction = 1
var transTime = 0
var damage = 1
var health = 4
var boxTime = 0
var blinkTime = 0
var knockForce = 200
var knockUp = -200

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var bullet = preload("res://scenes/misc/deathspark.tscn")

@onready var animations : AnimationPlayer = $AnimationPlayer
@onready var sprite : Sprite2D = $Sprite2D

func _physics_process(_delta):
	if (Globals.checkForCutsceneFreeze()): # freeze if in cutscene
		return

	if blinkTime > 0:
		blinkTime -= _delta
		modulate.a = 0.5
	else:
		modulate.a = 1

	if health <= 0:
		var inst = bullet.instantiate()
		get_tree().current_scene.add_child(inst)
		inst.global_position = global_position
		
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
		body._damaged(damage, direction, knockForce, knockUp)
		boxTime = .01

func _damaged(dam):
	health -= dam
	blinkTime = .1
