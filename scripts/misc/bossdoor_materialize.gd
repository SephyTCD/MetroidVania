extends bossdoorState
class_name bossdoor_materialize

func _enter():
	pass

func _update(_delta : float):
	bossdoor.animations.play("materialize")

func _exit():
	pass

func _end():
	state_transition.emit(self, "bossdoor_active")
