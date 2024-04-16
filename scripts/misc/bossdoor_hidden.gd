extends bossdoorState
class_name bossdoor_hidden

var target = null

func _enter():
	pass

func _update(_delta : float):
	
	target = get_tree().get_first_node_in_group("Player")
	
	bossdoor.modulate.a = 0

	bossdoor.animations.play("unactive")

func _exit():
		bossdoor.modulate.a = 1



func _on_area_2d_body_entered(body):
	if body == target:
		state_transition.emit(self, "bossdoor_materialize")
