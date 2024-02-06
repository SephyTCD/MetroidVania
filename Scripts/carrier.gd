extends CharacterBody2D

var condition = 1
var target = null
var health = 5
var damage = 20

var speed = 75
var gravity = 1800
var direction = 1
var dirLock = 0
var limit1 = 0
var limit2 = 0
var tick = 120
var walkLength = 41
var d2Tick = 60
var d1Tick = 60

var timer = 0

@onready var animations : AnimationPlayer = $AnimationPlayer
@onready var sprite : Sprite2D = $Sprite2D

#func _on_timer_timeout():
#	direction = randi_range(1,2)
#	dirLock = 1
#	print("test1")

# hi
#func floor_snap_stuff():
	#apply_floor_snap()

func _physics_process(delta):
	



	if health == 0:
		queue_free()
		
	
	
	# increment timer
	timer += 1
	if timer == 120: # if timer is reached...
		direction *= -1 # flip direction (this is basically just multiplying the value by -1
		timer = 0 # reset the timer
	
	sprite.flip_h = direction - 1 # silly coding trickery for one line code... shhhh...
	
	velocity.x = speed * direction # apply velocity
	
	move_and_slide()
	
	
	

func _on_area_2d_body_entered(body):
	
	condition = 2
	if body.name == "Player":
		target = body
		
		
		#print("check2")

func _on_area_2d_body_exited(body):
	condition = 1
	if body.name == "Player":
		target = null
		#print("check3")

func _take_damage():
	print("hit")
	health = health - 1
	print(health)
