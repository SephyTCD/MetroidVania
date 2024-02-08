extends CharacterBody2D

var move = true
var direction = 1
var speed = 500.0
var time = .35
var damage = 1
var crush = 0

@onready var animations : AnimationPlayer = $AnimationPlayer
@onready var sprite : Sprite2D = $Sprite2D

# Get the gravity from the project settings so you can sync with rigid body nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):

	time -= delta
	if time <= 0:
		queue_free()

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

func _unlock():
	crush = 1

func _on_area_2d_body_entered(body):
	print("entered")
	if body.has_method("_take_damage"):
		body._take_damage(damage)
	queue_free()
	if crush == 1:
		if body.has_method("_crush"):
			body._crush()
