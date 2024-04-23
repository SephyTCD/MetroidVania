extends CharacterBody2D
class_name gate_core

var health = 1

var gateResource : Resource
@export var gateResourcePath = ""

var bullet = preload("res://scenes/misc/deathspark.tscn")


func _ready():
	gateResource = PersistResource._load(gateResourcePath)
	if get_tree().current_scene.name == "Node2D2":
		gateResource.exist = true
	gateResource = PersistResource._load(gateResourcePath)
	if gateResource.exist == false:
		queue_free()

func _physics_process(delta):

	if health <= 0:
		gateResource.exist = false
		print(gateResource.exist)
		queue_free()

func _damaged(dam):
	var inst = bullet.instantiate()
	get_tree().current_scene.add_child(inst)
	inst.global_position = global_position
	health -= dam
