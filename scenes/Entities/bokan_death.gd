extends State
class_name bokan_death

var time = 2.5

var white = preload("res://scenes/misc/white_out.tscn")

func _enter():
	time = 2.5
	player.gravity = 50
	player.velocity.x = 0
	player.velocity.y = -50

	var inst = white.instantiate()
	get_tree().current_scene.add_child(inst)
	inst.global_position = player.marker.global_position

func _update(_delta : float):

	time -= _delta

	if time <= 0:
		get_tree().reload_current_scene()

func _exit():
	pass
