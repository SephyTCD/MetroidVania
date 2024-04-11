extends PerfuitState
class_name perfuit_walk

var distance = 0
var target = null
var walkTime = 3
var edgeDetect = null


func _enter():
	if perfuit.direction == 1:
		edgeDetect = %edge_detect_right
	if perfuit.direction == -1:
		edgeDetect = %edge_detect_left
	perfuit.speed = 40
	target = get_tree().get_first_node_in_group("Player")

func _update(_delta : float):
	
	if perfuit.direction == -1 and perfuit.speed != 0:
		perfuit.animations.play("perfuit_walk")
		perfuit.sprite.flip_h = false
	if perfuit.direction == 1 and perfuit.speed != 0:
		perfuit.animations.play("perfuit_walk")
		perfuit.sprite.flip_h = true
	
	perfuit.transTime -= _delta
	
	walkTime -= _delta
	
	if walkTime <= 0 or edgeDetect.is_colliding() == false or perfuit.is_on_wall():
		_change_direction()
		walkTime = 3

	if target != null:
		distance = target.global_position - perfuit.global_position
	else:
		pass

	
	if distance.length() < 180 and perfuit.transTime <= 0:
		state_transition.emit(self, "perfuit_attack")

func _exit():
	pass
	
func _change_direction():
	perfuit.direction *= -1
	if perfuit.direction == 1:
		edgeDetect = %edge_detect_right
	if perfuit.direction == -1:
		edgeDetect = %edge_detect_left
