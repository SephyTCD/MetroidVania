extends CharacterBody2D

var condition = 1
var target = null
var health = 5

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

@onready var animations : AnimationPlayer = $AnimationPlayer
@onready var sprite : Sprite2D = $Sprite2D

#func _on_timer_timeout():
#	direction = randi_range(1,2)
#	dirLock = 1
#	print("test1")

func _physics_process(delta):

	if health == 0:
		queue_free()

	if condition == 1:
		print("neutral")
		
		velocity.y += gravity * delta
		
		if walkLength != 0:
			walkLength -= 1

		if tick > 0:
			tick -= 1

		if tick == 0:
			tick = 100

		if tick == 1 and walkLength == 0:
			if limit1 != 3 and limit2 != 3:
				direction = randi_range(1,2)
				dirLock = 1
			if limit1 == 3:
				direction = 2
				dirLock = 1
			if limit2 == 3:
				direction = 1
				dirLock = 1
			#print("test1")

		if direction == 1 and dirLock == 1 and limit1 != 3:
			if d1Tick != 0:
				velocity.x = 50
				d1Tick -= 1
			if d1Tick == 0:
				velocity.x = 0
				dirLock = 0
				limit1 += 1
				walkLength = 41
				d1Tick = 60
				print(d1Tick)
				#print("test2")

		if direction == 2 and dirLock == 1 and limit2 != 3:
			if d2Tick != 0:
				velocity.x = -50
				d2Tick -= 1
				print(d2Tick)
			if d2Tick == 0:
				velocity.x = 0
				dirLock = 0
				limit2 += 1
				walkLength = 41
				d2Tick = 60
				#print("test3")

		if limit1 == 3:
			limit1 = 0

			#print("naaaah")

		if limit2 == 3:
			limit2 = 0
			#print("NAAAAAAH")

#	print(walkLength)

		if walkLength == 41:
			#print("hooooold up")
#	print(tick)

			if direction == 1:
				animations.play("move")
				sprite.flip_h = false
			if  direction == 2:
				animations.play("move")
				sprite.flip_h = true
			
			if is_equal_approx(velocity.x, 0):
				animations.play("jmove")
	move_and_slide()

	if condition == 2:
		if target:
			var direction = sign(target.global_position.x - global_position.x)
			velocity.x = direction * speed
			move_and_slide()

func _on_area_2d_body_entered(body):
	condition = 2
	if body.name == "Player":
		target = body
		print("check2")

func _on_area_2d_body_exited(body):
	condition = 1
	if body.name == "Player":
		target = null
		print("check3")

func _take_damage():
	print("hit")
	health = health - 1
	print(health)
