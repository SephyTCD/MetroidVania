extends CharacterBody2D
class_name Bossdoor

var materialize = 0

@onready var animations : AnimationPlayer = $AnimationPlayer

@export var event = 1
@export var globalPoseX = 0
@export var globalPoseY = 0

func _physics_process(delta):

	global_position.x = globalPoseX
	global_position.y = globalPoseY



