extends Moving
class_name bokan_wall_slide

var animLock = 0
var anim = "wall_slide"

func _enter():
	animLock = 0
	player.runLock = 0
	player.velocity.y = 100
	player.gravity = 100

func _update(_delta : float):
#//////////////////////////////////////////////////////////////////////////////
	#animations
	
	#print("slide")

	if Input.is_action_just_pressed("shoot"):
		animLock = 1

	if animLock == 1:
		anim = "wall_throw"
	else:
		anim = "wall_slide"

	if player.facing == -1:
		player.animations.play(anim)
		player.sprite.flip_h = false
	if player.facing == 1:
		player.animations.play(anim)
		player.sprite.flip_h = true

	_physics_update(_delta)

#//////////////////////////////////////////////////////////////////////////////
	#Transitions

	if player.is_on_wall() == false or player.direction == 0:
		player.velocity.y = 0
		state_transition.emit(self, "bokan_air")

	elif player.is_on_floor():
		player.velocity.y = 0
		state_transition.emit(self, "bokan_idle")

	elif Input.is_action_just_pressed("jump"):
		state_transition.emit(self, "bokan_wall_jump")

	elif player.damaged == 1:
		state_transition.emit(self, "bokan_damage")

func _exit():
	player.animLock = 0
	player.runLock = 0
	player.gravity = 1800
	player.facing *= -1
	player.marker.position.x *= -1

func _anim_unlock():
	animLock = 0
