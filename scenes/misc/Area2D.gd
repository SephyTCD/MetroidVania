extends Area2D
var target = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	target = get_tree().get_first_node_in_group("Player")


func _on_body_entered(body):
	if body == target:
		CheckPoint.lastPose = null
		get_tree().change_scene_to_file("res://scenes/Maps/intro_level2.tscn")
