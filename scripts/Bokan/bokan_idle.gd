extends State
class_name bokan_idle

func _enter():
	pass

func _update(_delta : float):
#//////////////////////////////////////////////////////////////////////////////
	#animations
	
	if is_equal_approx(player.velocity.x, 0) and player.animLock == 0:
		player.animations.play("idle")

#//////////////////////////////////////////////////////////////////////////////
	#Transitions

	if player.is_on_floor() == true:
		player.runLock = 0

	if player.direction != 0 and player.is_on_floor():
		state_transition.emit(self, "bokan_run")

	elif Input.is_action_just_pressed("jump") and player.is_on_floor() or player.is_on_floor() and player.jumpBuff > 0:
		$"../../sounds/jump".play()
		state_transition.emit(self, "bokan_jump")

	elif player.is_on_floor() == false:
		state_transition.emit(self, "bokan_air")

	#elif player.damaged == 1:
		#state_transition.emit(self, "bokan_damage")

	if Globals.health <= 0:
		state_transition.emit(self, "bokan_death")

func _exit():
	pass
