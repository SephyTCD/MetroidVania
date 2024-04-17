extends TileMap

var state = 0
var target = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	target = get_tree().get_first_node_in_group("Player")

	if state == 0:
		modulate.a = 0
		

func _on_area_2d_body_entered(body):
	if body == target:
		state = 1

