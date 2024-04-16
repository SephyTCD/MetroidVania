extends CharacterBody2D

@onready var animations : AnimationPlayer = $AnimationPlayer

func _physics_process(delta):

	animations.play("spark")

func _sound():
	$AudioStreamPlayer.play()

func _end():
	queue_free()
