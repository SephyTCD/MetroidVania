extends CharacterBody2D



var time = 0
var anim = null

@export var speed = 50
@export var size = 1
@export var turn = 1
@export var reTime = .50

@onready var animations : AnimationPlayer = $AnimationPlayer

func _physics_process(_delta):
	
	if size == 1:
		anim = "small"
	if size == 2:
		anim = "large"
	
	animations.play(anim)
	
	time -= _delta

	if time <= 0 and turn == 1:
		turn *= -1
		time = reTime
	if time <= 0 and turn == -1:
		turn *= -1
		time = reTime

	velocity.x = speed * turn

	move_and_slide()
