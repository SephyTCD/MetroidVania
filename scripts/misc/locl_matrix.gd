extends CharacterBody2D

var health = 1

var gateResource : Resource
@export var gateResourcePath = ""

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
		queue_free()

func _damaged(dam):
	health -= dam
