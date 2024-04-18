extends CanisState
class_name canis_run

var time = 1

func _enter():
	canis.speed = 300
	time = 1

func _update(_delta : float):
	
	if canis.direction == -1:
		canis.animations.play("canis_run")
		canis.sprite.flip_h = false
	if canis.direction == 1:
		canis.animations.play("canis_run")
		canis.sprite.flip_h = true
	
	canis.velocity.x = canis.speed * canis.direction

	if time > 0:
		time -= _delta

	if time <= 0 or canis.is_on_wall() == true:
		state_transition.emit(self, "canis_neutral")

	if canis.health <= 0:
		state_transition.emit(self, "canis_death")

func _exit():
	pass

func _sound():
	$"../../sounds/run".play()
