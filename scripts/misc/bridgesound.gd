extends Node

var target = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	target = get_tree().get_first_node_in_group("Player")


func _on_area_2d_body_entered(body):
	if body == target:
		$bridgesound.play()
