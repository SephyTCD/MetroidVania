extends WandererState
class_name wanderer_attack

var time = 1.0
var target = null

func _enter():
	wanderer.speed = 0
	time = 1.0
	wanderer.velocity.x = wanderer.direction * wanderer.speed

	if wanderer.direction == -1:
		wanderer.animations.play("wanderer_attack")
		wanderer.sprite.flip_h = false
	if wanderer.direction == 1:
		wanderer.animations.play("wanderer_attack")
		wanderer.sprite.flip_h = true

func _update(_delta : float):
	time -= _delta
	
	if time < 0:
		state_transition.emit(self, "wanderer_chase")

func _exit():
	pass

func _dash():
	wanderer.speed = 500
	wanderer.velocity.x = 500 * wanderer.direction

func _break():
	wanderer.speed = 0
	wanderer.velocity.x = 0
