extends CharacterBody2D


var speed = 100.0
var speedTime = .40
var target = null
var origin = 0
var orLock = 1
var stun = 0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	if Globals.inCutscene: # Prevent physics update when in cutscene
		return 
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	if velocity.x == 200:
		speedTime -= delta
	if speedTime <= 0:
		velocity.x = 0
		speedTime = .40
		stun = 0
		

	if orLock == 1:
		origin = global_position.x
		orLock = 0

	if stun == 0:
		velocity.x = origin - global_position.x


	move_and_slide()

func _on_killbox_body_entered(body):
	print("stepped on stuff")
	_hazard()

func _crush():
	print("push")
	velocity.x = 200
	stun = 1

func _hazard():
	queue_free()
