extends CharacterBody2D

var anim = null
var freeze = 0
var target = null

@export var state = 0
@export var stateAct = 1

@export var globalPoseX = 0
@export var globalPoseY = 0

@onready var animations : AnimationPlayer = $AnimationPlayer

var flicker = preload("res://Assets/misc/flicker.tscn")

func _physics_process(_delta):

	#print(global_position)

	target = get_tree().get_first_node_in_group("Player")

	if state == 0:
		anim = "idle"
	if state == 1:
		anim = "active"

	global_position.x = globalPoseX
	global_position.y = globalPoseY

	if freeze > 0:
		Globals.inCutscene = true
		freeze -= _delta
	if freeze < 0:
		Globals.inCutscene = false

	animations.play(anim)


func _on_area_2d_body_entered(body):
	if body == target:
		if stateAct == 1:
			freeze = .3
			$gate_close.play()
			var inst = flicker.instantiate()
			get_tree().current_scene.add_child(inst)
			inst.global_position = global_position
			stateAct = 0
		state = 1
