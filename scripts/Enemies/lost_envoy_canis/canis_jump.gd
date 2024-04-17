extends CanisState
class_name canis_jump

var airTime = .80
var endAble = 0
var anim = "canis_jump"

func _enter():
	canis.speed = 300
	canis.velocity.y = -300
	airTime = .80
	endAble = 0

func _update(_delta : float):

	if canis.velocity.y < 0:
		anim = "canis_jump"
	else:
		anim = "canis_air"

	if canis.direction == -1:
		canis.animations.play(anim)
		canis.sprite.flip_h = false
	if canis.direction == 1:
		canis.animations.play(anim)
		canis.sprite.flip_h = true

	canis.velocity.x = canis.speed * canis.direction


	if canis.velocity.y >= 0 and airTime > 0:
		airTime -= _delta
		canis.velocity.y = 0
		canis.gravity = 0

	if airTime <= 0 or canis.is_on_wall() == true:
		canis.gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
		canis.velocity.y += canis.gravity * _delta
		endAble = 1

	if canis.is_on_floor() == true and endAble == 1:
		state_transition.emit(self, "canis_neutral")

func _exit():
	pass

func _sound():
	$"../../sounds/jump".play()
