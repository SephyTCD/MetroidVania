extends State
class_name bokan_wall_run

var timer = 3

func _enter():
	player.velocity.x = player.facing * 250
	player.gravity = 0
	player.velocity.y = 0
	timer = 3

func _update(_delta : float):
#//////////////////////////////////////////////////////////////////////////////
	#animations
	if player.velocity.x > 0:
		player.animations.play("wall_run")
		player.sprite.flip_h = false
	if player.velocity.x < 0:
		player.animations.play("wall_run")
		player.sprite.flip_h = true
	if is_equal_approx(player.velocity.x, 0):
		player.animations.play("wall_run")

#//////////////////////////////////////////////////////////////////////////////
	#Transitions

	timer -= _delta

	if timer <= 0 or player.is_on_wall() == true or Input.is_action_just_released("wall_run") or player.wallRunAble == 0:
		state_transition.emit(self, "bokan_air")
		#player.runLock = 1

	if Input.is_action_just_pressed("jump"):
		state_transition.emit(self, "bokan_jump")
		#player.runLock = 1

	#elif player.damaged == 1:
		#state_transition.emit(self, "bokan_damage")
		#player.runLock = 1

func _exit():
	player.runLock = 1
	player.gravity = 1800
