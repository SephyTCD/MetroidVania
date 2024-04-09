extends ProvocatorState
class_name provocator_idle

var target = null
var distance = 0

func _enter():
	target = get_tree().get_first_node_in_group("Player")
	

func _update(_delta : float):
	
	if provocator.direction == -1:
		provocator.animations.play("provocator_idle")
		provocator.sprite.flip_h = false
	if provocator.direction == 1:
		provocator.animations.play("provocator_idle")
		provocator.sprite.flip_h = true

	provocator.transTime -= _delta

	if target != null:
		provocator.direction = sign(target.global_position.x - provocator.global_position.x)
	else:
		pass

	if target != null:
		distance = target.global_position - provocator.global_position
	else:
		pass

	if distance.length() < 250 and provocator.transTime <= 0:
		state_transition.emit(self, "provocator_attack")

func _exit():
	pass
	
