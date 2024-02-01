extends CharacterBody2D

var move = true
var direction = 1
var speed = 500.0

@onready var animations : AnimationPlayer = $AnimationPlayer
@onready var sprite : Sprite2D = $Sprite2D

# Get the gravity from the project settings so you can sync with rigid body nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):

	if direction > 0:
		animations.play("paper_spin")
		sprite.flip_h = false
	if direction < 0:
		animations.play("paper_spin")
		sprite.flip_h = true

	if Input.is_action_pressed("ui_right"):
		direction = 1
	if Input.is_action_pressed("ui_left"):
		direction = -1
		
		
	velocity.x = speed

	move_and_slide()
