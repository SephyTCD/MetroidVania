extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var timer = $Timer

var condition = 1
var target = null
var health = 5
var damage = 20
var whileMoving = true

var speed = 100
var gravity = 1800
var direction = 1
var dirLock = 0
var limit1 = 0
var limit2 = 0
var tick = 120
var walkLength = 41
var d2Tick = 60
var d1Tick = 60

func _physics_process(delta):
	if health == 0:
		queue_free()
		
	move_and_slide()

#sight for the attack
func _on_sight_body_entered(body):
	if body.name == "Player":
		_swoop_down()

#goal is to hve the bird swoop down in an arc
func _swoop_down():
	print("swoop!")
	velocity.y = speed
	velocity.x = -speed
	
