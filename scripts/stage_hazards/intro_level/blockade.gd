extends CharacterBody2D

var anim = null

var target = null

@export var state = 0

@onready var animations : AnimationPlayer = $AnimationPlayer


func _physics_process(delta):

	target = get_tree().get_first_node_in_group("Player")

	print(state)

	if state == 0:
		anim = "idle"
	if state == 1:
		anim = "active"

	animations.play(anim)


func _on_area_2d_body_entered(body):
	if body == target:
		state = 1
