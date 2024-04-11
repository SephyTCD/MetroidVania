extends Moving
class_name bokan_run

func _enter():
	pass

func _update(_delta : float):
	#print("run")
	_physics_update(_delta)

#//////////////////////////////////////////////////////////////////////////////
	#animations
	if player.velocity.x > 0 and player.is_on_floor() and player.animLock == 0:
		player.animations.play("run")
		player.sprite.flip_h = false
	if player.velocity.x < 0 and player.is_on_floor() and player.animLock == 0:
		player.animations.play("run")
		player.sprite.flip_h = true
	if is_equal_approx(player.velocity.x, 0) and player.animLock == 0:
		player.animations.play("idle")

#//////////////////////////////////////////////////////////////////////////////
	#Transitions

	if player.velocity.x == 0 and player.is_on_floor() and \
	Input.is_action_pressed("ui_left") == false and Input.is_action_pressed("ui_right") == false:
		state_transition.emit(self, "bokan_idle")

	elif Input.is_action_just_pressed("jump") and player.is_on_floor():
		state_transition.emit(self, "bokan_jump")

	elif player.is_on_floor() == false:
		state_transition.emit(self, "bokan_air")

	#elif player.damaged == 1:
		#state_transition.emit(self, "bokan_damage")

func _exit():
	player.runLock = 0
