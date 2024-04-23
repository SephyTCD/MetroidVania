extends State
class_name bokan_wall_stall

var animLock = 0
var anim = "wall_slide"
var hangTime = .3

func _enter():
	hangTime = .3
	animLock = 0
	player.runLock = 0
	player.velocity.y = 100
	player.gravity = 100

func _update(_delta : float):
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

#//////////////////////////////////////////////////////////////////////////////

	hangTime -= _delta
	
	if hangTime <= 0:
		state_transition.emit(self, "bokan_air")


func _exit():
	player.animLock = 0
	player.runLock = 0
	player.gravity = 1800
	player.facing *= -1
	player.marker.position.x *= -1

func _anim_unlock():
	animLock = 0
