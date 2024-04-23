extends State
class_name bokan_jump

func _enter():
	player.velocity.y = player.jump_speed
	#print("jump")

func _update(_delta : float):
	player.jump_speed = -500

	state_transition.emit(self, "bokan_air")

	if Globals.health <= 0:
		state_transition.emit(self, "bokan_death")

func _exit():
	pass
