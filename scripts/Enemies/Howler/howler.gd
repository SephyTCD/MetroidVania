extends CharacterBody2D
class_name Howler

var damage = 1
var boxTime = 0
var knockForce = 200
var knockUp = -200

@export var direction = 1

@onready var animations : AnimationPlayer = $AnimationPlayer
@onready var sprite : Sprite2D = $Sprite2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var bullet = preload("res://scenes/misc/deathspark.tscn")


func _physics_process(_delta):
	if (Globals.checkForCutsceneFreeze()): # freeze if in cutscene
		return

	velocity.y += gravity * _delta

	if boxTime > 0:
		boxTime -= _delta
		$Area2D/CollisionShape2D.disabled = true
	else:
		$Area2D/CollisionShape2D.disabled = false

	if direction == 1:
		$Marker2D.position.x = abs($Marker2D.position.x) * 1
	if direction == -1:
		$Marker2D.position.x = abs($Marker2D.position.x) * -1

	move_and_slide()

func _on_area_2d_body_entered(body):
	if body.has_method("_damaged"):
		body._damaged(damage, direction, knockForce, knockUp)
		boxTime = .01
