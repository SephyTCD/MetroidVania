extends CharacterBody2D
class_name Alandra

var speed = 200
var jumpSpeed = -500
var trigger = 0
var target = null
var despawn = 0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = 1000

@export var jumpForce = -500
@export var direction = 1
@export var event = 1

@onready var animations : AnimationPlayer = $AnimationPlayer
@onready var sprite : Sprite2D = $Sprite2D

func _physics_process(_delta):
	target = get_tree().get_first_node_in_group("Player")
	

	velocity.y += gravity * _delta

	if despawn == 1:
		Globals.inCutscene = false
		queue_free()

	if event == 1:
		$event2/CollisionShape2D.set_deferred("disabled", true)

	if event == 2:
		$event1/CollisionShape2D.set_deferred("disabled", true)

	move_and_slide()

func _on_area_2d_body_entered(body):
	if body == target:
		trigger = 1

func _on_event_2_body_entered(body):
	if body == target:
		trigger = 1
