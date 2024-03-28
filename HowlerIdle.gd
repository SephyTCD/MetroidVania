extends HowlerState
class_name HowlerIdle

var time = .50
var target = null

func _enter():
	time = .50
	target = get_tree().get_first_node_in_group("Player")

func _update(_delta : float):
	howler.direction = sign(target.global_position.x - howler.global_position.x)
	time -= _delta
	
	if time < 0:
		state_transition.emit(self, "HowlerShoot")

	if howler.direction == -1:
		howler.animations.play("idle")
		howler.sprite.flip_h = false
	if howler.direction == 1:
		howler.animations.play("idle")
		howler.sprite.flip_h = true

func _exit():
	pass
