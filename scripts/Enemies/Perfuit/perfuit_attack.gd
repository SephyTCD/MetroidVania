extends PerfuitState
class_name perfuit_attack

var target = null

func _enter():
	perfuit.velocity.x = 0
	perfuit.speed = 0
	target = get_tree().get_first_node_in_group("Player")
	if target != null:
		perfuit.direction = sign(target.global_position.x - perfuit.global_position.x)
	else:
		pass

func _update(_delta : float):
	
	
	if perfuit.direction == -1:
		perfuit.animations.play("perfuit_pounce")
		perfuit.sprite.flip_h = false
	if perfuit.direction == 1:
		perfuit.animations.play("perfuit_pounce")
		perfuit.sprite.flip_h = true

func _exit():
	perfuit.transTime = 1

func _pounce():
	perfuit.speed = 300
	perfuit.velocity.y = perfuit.jumpSpeed
	perfuit.velocity.x = perfuit.direction * perfuit.speed

func _end():
	if perfuit.is_on_floor():
		state_transition.emit(self, "perfuit_walk")
