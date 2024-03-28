extends CharacterBody2D
class_name Howler

var direction = 1

@onready var animations : AnimationPlayer = $AnimationPlayer
@onready var sprite : Sprite2D = $Sprite2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):

	move_and_slide()
