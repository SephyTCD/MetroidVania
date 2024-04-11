extends DrifterState
class_name drifter_wander

var distance = 0
var target = null
var walkTime = 3

func _enter():
	drifter.speed = 40
	target = get_tree().get_first_node_in_group("Player")

func _update(_delta : float):

	walkTime -= _delta

	if walkTime <= 0 or drifter.is_on_wall():
		_change_direction()
		walkTime = 3

	drifter.velocity.x = drifter.speed * drifter.direction

	if target != null:
		distance = target.global_position - drifter.global_position
	else:
		pass

	if distance.length() < 100:
		state_transition.emit(self, "drifter_dash")

func _exit():
	pass

func _change_direction():
	drifter.direction *= -1

