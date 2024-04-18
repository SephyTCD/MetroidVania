extends CharacterBody2D

@onready var animations : AnimationPlayer = $AnimationPlayer


func _physics_process(delta):

	animations.play("flicker")


func _end():
	queue_free()
