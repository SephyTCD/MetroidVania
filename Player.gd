extends CharacterBody2D

#Hi Hazel, type here!!!
#A chair is a piece of furniture with a raised surface supported by legs, commonly used to seat a single person. Chairs are supported most often by four legs and have a back; however, a chair can have three legs or can have a different shape. Chairs are made of a wide variety of materials, ranging from wood to metal to synthetic material (e.g. plastic), and they may be padded or upholstered in various colors and fabrics, either just on the seat (as with some dining room chairs) or on the entire chair. Chairs are used in a number of rooms in homes (e.g. in living rooms, dining rooms, and dens), in schools and offices (with desks), and in various other workplaces, such as the Black Mesa facility.

#God damn muthafuckin' yoig mastah

#Movement
var speed = 250.0
var move = true
var moveLock = 11

#Jumping
var jump_speed = -500.0
var wallJumpSpeed = -400

#Facing
var facing = 1
var faceLock = 0

#WallRun
var runTime = 100
var runAble = 1
var runUse = 1
var onWall = 0
var wallRunning = 0
var onFloor = 1
var wallSlide = false
var wallSlideGrav = 100
var direction = 0


# Get the gravity from the project settings so you can sync with rigid body nodes.
var gravity = 1800

@onready var animations : AnimationPlayer = $AnimationPlayer
@onready var sprite : Sprite2D = $Sprite2D

func _on_area_2d_body_entered(body):
	#print("test")
	onWall = 1

func _on_area_2d_body_exited(body):
	onWall = 0
	move = true
	wallRunning = 0
	moveLock = 11
	if runUse == 0:
		runAble = 0
	
	#print("test2")

func _physics_process(delta):
	# Add the gravity.
	velocity.y += gravity * delta

# Handle Jump.
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = jump_speed
			
		if is_on_wall() and Input.is_action_pressed("ui_right") and is_on_floor() == false:
			velocity.y = wallJumpSpeed
			moveLock = 10
			velocity.x = -300
			#print("test")
		if is_on_wall() and Input.is_action_pressed("ui_left") and is_on_floor() == false:
			velocity.y = wallJumpSpeed
			moveLock = 10
			velocity.x = 300
			#print("test")
		if wallRunning == 1:
			velocity.y = jump_speed
			wallRunning = 0
			runAble = 0
			

	if wallRunning == 1:
		moveLock = 10
		if moveLock == 1:
			moveLock = 10

	if moveLock < 11:
		moveLock -=  1
		move = false

	if moveLock == 0:
		moveLock = 11

# Get the input direction / allow move controls when true.
	if moveLock == 11:
		move = true

	if move == true:
		direction = Input.get_axis("ui_left", "ui_right")
		velocity.x = direction * speed
		
		


	if Input.is_action_just_pressed("ui_right"):
		facing = 1
	if Input.is_action_just_pressed("ui_left"):
		facing = 2

#wall slide
	if is_on_wall() and !is_on_floor():
		if Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right"):
			wallSlide = true
		else:
			wallSlide = false
	else:
		wallSlide = false

	if wallSlide == true:
		velocity.y += (100 * delta)
		velocity.y = min(velocity.y, wallSlideGrav)
		

#Wall Running
	if Input.is_action_pressed("wallRun") and is_on_floor() == false and runTime != 0 and runAble == 1 and onWall == 1:
		velocity.y = 0
		wallRunning = 1
		runUse = 0
		move = false
		runTime -= 1
		if facing == 1 and faceLock == 0:
			velocity.x = 300
			faceLock = 1
		if facing == 2 and faceLock == 0:
			velocity.x = -300
			faceLock = 1

	if Input.is_action_just_released("wallRun"):
		move = true

		runAble = 0
		wallRunning = 0

	if is_on_floor():
		faceLock = 0
		runTime = 100
		runAble = 1
		runUse = 1

	if is_on_floor() == true:
		if direction > 0:
			animations.play("run_right")
			sprite.flip_h = false
		if direction < 0:
			animations.play("run_right")
			sprite.flip_h = true
			
		if is_equal_approx(velocity.x, 0):
			animations.play("idle_right")
			
	if is_on_floor() == false and wallRunning != 1:
		if direction > 0:
			animations.play("jump_right")
			sprite.flip_h = false
		if  direction < 0:
			animations.play("jump_right")
			sprite.flip_h = true
			
		if is_equal_approx(velocity.x, 0):
			animations.play("jump_right")

	if wallRunning == 1:
		if direction > 0:
			animations.play("wallrun_right")
			sprite.flip_h = false
		if direction < 0:
			animations.play("wallrun_right")
			sprite.flip_h = true
	#print(runTime)
	#print(moveLock)



	move_and_slide()
