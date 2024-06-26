extends CharacterBody2D
class_name Player

var speed = 200.0
var jump_speed = -500

var runLock = 0
var moveLock = 0
var freeze = 0

var direction = 0
var facing = 1

var wallRunAble = 0
var jumpBuff = 0

var health = 10
var maxHealth = 10
var invTime = 0
var knockBack = 0
var knockForce = 200
var knockUp = -200
var onHazard = 0

var gravity = 1800

var animLock = 0
var shootLock = 0

@onready var marker = $Marker2D

@onready var animations : AnimationPlayer = $AnimationPlayer
@onready var sprite : Sprite2D = $Sprite2D

signal playerDamaged

func _physics_process(_delta):
	if (Globals.checkForCutsceneFreeze()): # freeze if in cutscene
		return
	
#//////////////////////////////////////////////////////////////////////////////
	#Health details

	$Camera2D/RichTextLabel.set_text("Health\n"+str(Globals.health)+"/"+str(Globals.maxHealth))
	
	if invTime > 0:
		invTime -= _delta
		modulate.a = 0.5
	else:
		modulate.a = 1
	
	if onHazard == 1 and invTime <= 0:
		Globals.health -= 3
		knockBack = facing * -1
		playerDamaged.emit()
	
	if Globals.health > Globals.maxHealth:
		Globals.health = Globals.maxHealth

	if Globals.health <= 0:
		Globals.health <= 0
		$wall_detect/CollisionShape2D.set_deferred("disabled", true)
		$CollisionShape2D.set_deferred("disabled", true)

#//////////////////////////////////////////////////////////////////////////////
	#Movement details

	velocity.y += gravity * _delta

	if jumpBuff > 0:
		jumpBuff -= _delta

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

func _damaged(dam, dir, kof, kou):
	if invTime <= 0:
		Globals.health -= dam
		knockBack = dir
		knockForce = kof
		knockUp = kou
		print(health)
		playerDamaged.emit()

func _heal(heal):
	Globals.health += heal

func _maxup():
	Globals.maxHealth += 2
	Globals.health = 20

#//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	#wallrun

func _on_wall_detect_body_entered(body):

	if body.has_method("_allowRun"):
		wallRunAble = 1

	if body.has_method("_spike"):
		onHazard = 1

func _on_wall_detect_body_exited(body):
	wallRunAble = 0

	onHazard = 0
