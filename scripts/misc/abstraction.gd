extends CharacterBody2D

var gateResource : Resource
@export var gateResourcePath = ""

var flicker = preload("res://scenes/misc/absflicker.tscn")

func _ready():
	gateResource = PersistResource._load(gateResourcePath)
	if get_tree().current_scene.name == "Node2D2":
		gateResource.exist = true
	gateResource = PersistResource._load(gateResourcePath)
	if gateResource.exist == false:
		queue_free()

func _physics_process(delta):
	pass


func _on_area_2d_body_entered(body):
	if body.has_method("_maxup"):
		body._maxup()
		var inst = flicker.instantiate()
		get_tree().current_scene.add_child(inst)
		inst.global_position = global_position
		gateResource.exist = false
		queue_free()
