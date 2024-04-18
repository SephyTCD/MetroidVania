extends CharacterBody2D


@onready var animations : AnimationPlayer = $AnimationPlayer

func _physics_process(delta):

	animations.play("white_out")

	move_and_slide()
