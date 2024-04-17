extends MassState
class_name mass_follow

var time = 1

func _enter():
	pass

func _update(_delta : float):

	time -= _delta

	mass.velocity.x = mass.speed

	if time <= 0:
		state_transition.emit(self, "mass_backoff")

func _exit():
	pass
	

