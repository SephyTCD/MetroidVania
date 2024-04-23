extends Moving
class_name bokan_air

var coyTime = .03

func _enter():
	pass

func _update(_delta : float):
	
	_physics_update(_delta)

#//////////////////////////////////////////////////////////////////////////////
	#animations

	if player.velocity.x > 0 and player.animLock == 0:
		player.animations.play("air")
		player.sprite.flip_h = false
	if player.velocity.x < 0 and player.animLock == 0:
		player.animations.play("air")
		player.sprite.flip_h = true
	if is_equal_approx(player.velocity.x, 0) and player.animLock == 0:
		player.animations.play("air")

	if player.is_on_floor() == true:
		coyTime = .03

	if player.velocity.y < 0 and Input.is_action_just_released("jump"):
		player.velocity.y = player.velocity.y * .65

#//////////////////////////////////////////////////////////////////////////////
	#Transitions

	if Input.is_action_just_pressed("jump"):
		player.jumpBuff = .1

	if coyTime > 0:
		coyTime -= _delta
		if Input.is_action_pressed("jump") and player.velocity.y > 0 or player.jumpBuff == .3 and player.velocity.y > 0:
			state_transition.emit(self, "bokan_jump")

#/////////////////

	if Input.is_action_pressed("wall_run") and player.wallRunAble == 1 and player.runLock == 0:
		state_transition.emit(self, "bokan_wall_run")

#/////////////////

	if player.is_on_wall() and player.is_on_floor() == false and player.velocity.y >= 0:
		if Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right"):
			state_transition.emit(self, "bokan_wall_slide")

#////////////////

	elif Input.is_action_just_pressed("jump") and player.is_on_wall() == true:
		player.facing *= -1
		state_transition.emit(self, "bokan_wall_jump")

	#if Input.is_action_just_pressed("jump") and player.hangTime > 0:
		#state_transition.emit(self, "bokan_wall_jump")

#/////////////

	elif player.is_on_floor():
		$"../../sounds/land".play()
		state_transition.emit(self, "bokan_idle")

#/////////////

	if Globals.health <= 0:
		state_transition.emit(self, "bokan_death")

#/////////////

	#elif player.damaged == 1:
		#state_transition.emit(self, "bokan_damage")

func _exit():
	pass
