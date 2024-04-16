extends CharacterBody2D


@export var globalPoseX = 0
@export var globalPoseY = 0

func _physics_process(delta):

	global_position.x = globalPoseX
	global_position.y = globalPoseY
