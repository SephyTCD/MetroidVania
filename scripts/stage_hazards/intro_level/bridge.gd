extends TileMap

var target = null

@onready var marker = $Marker2D
@onready var marker2 = $Marker2D2
@onready var marker3 = $Marker2D3
@onready var marker4 = $Marker2D4

var bullet = preload("res://scenes/misc/broke_bridge_right.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	target = get_tree().get_first_node_in_group("Player")



func _on_area_2d_body_entered(body):
	if body == target:
		var inst = bullet.instantiate()
		get_tree().current_scene.add_child(inst)
		inst.global_position = marker.global_position
		inst.direction = 1
		inst.gravity = 1700

		var inst2 = bullet.instantiate()
		get_tree().current_scene.add_child(inst2)
		inst2.global_position = marker2.global_position
		inst2.direction = -1
		inst2.gravity = 2100

		var inst3 = bullet.instantiate()
		get_tree().current_scene.add_child(inst3)
		inst3.global_position = marker3.global_position
		inst3.direction = 1
		inst3.gravity = 1900

		var inst4 = bullet.instantiate()
		get_tree().current_scene.add_child(inst4)
		inst4.global_position = marker4.global_position
		inst4.direction = -1
		inst4.gravity = 2300
		
		queue_free()
