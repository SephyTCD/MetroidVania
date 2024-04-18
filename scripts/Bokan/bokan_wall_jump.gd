extends State
class_name bokan_wall_jump

var time = .20

func _enter():
	player.facing *= -1
	if player.facing == -1:
		player.animations.play("wall_kick")
		player.sprite.flip_h = false
	if player.facing == 1:
		player.animations.play("wall_kick")
		player.sprite.flip_h = true
	$"../../sounds/wall_jump".play()
	time = .20
	player.shootLock = 1
	player.velocity.x = 0
	player.velocity.y = 0
	player.gravity = 0

func _update(_delta : float):

	if time > 0:
		time -= _delta
	
	if time <= 0:
		state_transition.emit(self, "bokan_air")

	#elif player.damaged == 1:
		#state_transition.emit(self, "bokan_damage")

	if player.health <= 0:
		state_transition.emit(self, "bokan_death")

func _exit():
	pass

func _kick():

	player.gravity = 1800
	player.velocity.x = -300 * player.facing
	player.velocity.y = -400
	

func _shootFree():
	
	player.shootLock = 0
