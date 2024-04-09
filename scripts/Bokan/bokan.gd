extends CharacterBody2D
class_name Player

var speed = 200.0
var jump_speed = -500

var runLock = 0
var moveLock = 0

var direction = 0
var facing = 1

var wallRunAble = 0

var health = 10
var damaged = 0
var invTime = 0
var knockBack = 0

var gravity = 1800

var animLock = 0
var shootLock = 0

@onready var marker = $Marker2D

@onready var animations : AnimationPlayer = $AnimationPlayer
@onready var sprite : Sprite2D = $Sprite2D

func _physics_process(_delta):
	if (Globals.checkForCutsceneFreeze()): # freeze if in cutscene
		return
	
	
#//////////////////////////////////////////////////////////////////////////////
	#Health details
	
	if invTime > 0:
		invTime -= _delta
		modulate.a = 0.5
	else:
		modulate.a = 1
	
	if health <= 0:
		queue_free()

#//////////////////////////////////////////////////////////////////////////////
	#Movement details

	velocity.y += gravity * _delta

	if moveLock > 0:
		moveLock -= _delta

	if moveLock <= 0:
		direction = Input.get_axis("ui_left", "ui_right")

#/////////////////////////////
	#facing
		if velocity.x < 0:
			facing = -1
			$Marker2D.position.x = abs($Marker2D.position.x) * -1

		if velocity.x > 0:
			facing = 1
			$Marker2D.position.x = abs($Marker2D.position.x) * 1

	move_and_slide()

#//////////////////////////////////////////////////////////////////////////////
	#damage code

func _damaged(dam, dir):
	if invTime <= 0:
		health -= dam
		knockBack = dir
		print(health)
		damaged = 1

#//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	#wallrun

func _on_wall_detect_body_entered(body):
	wallRunAble = 1


func _on_wall_detect_body_exited(body):
	wallRunAble = 0
