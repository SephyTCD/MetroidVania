extends CharacterBody2D

var anim = null

var target = null

@export var state = 0

@export var globalPoseX = 0
@export var globalPoseY = 0

@onready var animations : AnimationPlayer = $AnimationPlayer


func _physics_process(delta):

	#print(global_position)

	target = get_tree().get_first_node_in_group("Player")

	if state == 0:
		anim = "idle"
	if state == 1:
		anim = "active"

	global_position.x = globalPoseX
	global_position.y = globalPoseY


	animations.play(anim)


func _on_area_2d_body_entered(body):
	if body == target:
		print("dang")
		state = 1
