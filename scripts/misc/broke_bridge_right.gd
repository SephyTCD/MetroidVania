extends CharacterBody2D

var direction = 1
var gravity = 1800

@onready var sprite : Sprite2D = $Sprite2D


func _physics_process(delta):

	if direction == 1:
		sprite.flip_h = false
	if direction == -1:
		sprite.flip_h = true

	velocity.y += gravity * delta

	move_and_slide()
