extends CharacterBody2D
class_name Mass

var time = 7
var speed = 180
var direction = 1
var damage = 0
var boxTime = 0
var knockBack = 1000
var knockForce = -500
var distance = 0
var startDistance
var chaseLock = 0
var target = null
var start = 0

@onready var animations : AnimationPlayer = $AnimationPlayer

func _ready():
	start = global_position

func _physics_process(_delta):

	target = get_tree().get_first_node_in_group("Player")

	animations.play("pulse")

	if boxTime > 0:
		boxTime -= _delta
		$Area2D/CollisionShape2D.disabled = true
	else:
		$Area2D/CollisionShape2D.disabled = false

		time -= _delta

	velocity.x = speed * direction

	if target != null:
		distance = target.global_position - global_position
	else:
		pass

	startDistance = start - global_position

	if chaseLock == 0:
		if distance.length() < 250:
			speed = 300

		if distance.length() < 225:
			speed = 280

		if distance.length() < 200:
			speed = 270

		if distance.length() < 190:
			speed = 25

	if startDistance.length() > 1150:
		chaseLock = 1
		direction = -1
		speed = 50

	if time < -15:
		queue_free()

	move_and_slide()


func _on_area_2d_body_entered(body):
	if body.has_method("_damaged"):
		body._damaged(damage, direction, knockBack, knockForce)
		boxTime = .01
