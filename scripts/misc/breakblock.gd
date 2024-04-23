extends CharacterBody2D
class_name break_block

var target = null

var gateResource : Resource
@export var gateResourcePath = ""

func _ready():
	gateResource = PersistResource._load(gateResourcePath)
	if get_tree().current_scene.name == "Node2D2":
		gateResource.exist2 = true
	gateResource = PersistResource._load(gateResourcePath)
	if gateResource.exist2 == false:
		queue_free()

func _physics_process(delta):

	target = get_tree().get_first_node_in_group("Player")


func _on_area_2d_body_entered(body):
	if body == target:
		gateResource.exist2 = false
		queue_free()
