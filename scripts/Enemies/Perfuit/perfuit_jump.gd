extends PerfuitState
class_name perfuit_jump

var target = null

func _enter():
	perfuit.velocity.x = 0
	perfuit.speed = 0
	target = get_tree().get_first_node_in_group("Player")
	if target != null:
		perfuit.direction = sign(target.global_position.x - perfuit.global_position.x)
	else:
		pass
	perfuit.speed = 300
	perfuit.velocity.y = perfuit.jumpSpeed
	perfuit.velocity.x = perfuit.direction * perfuit.speed
func _update(_delta : float):
	
	if perfuit.direction == -1:
		perfuit.animations.play("perfuit_pounce")
		perfuit.sprite.flip_h = false
	if perfuit.direction == 1:
		perfuit.animations.play("perfuit_pounce")
		perfuit.sprite.flip_h = true
	
	state_transition.emit(self, "perfuit_attack")

func _exit():
	perfuit.transTime = .55
