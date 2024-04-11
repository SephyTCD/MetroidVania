extends DrifterState
class_name drifter_dash

var wait = .50
var dashTime = 0.0
var target  = null
var distance = 0
var angle = 0

func _enter():
	wait = 1.0
	drifter.velocity.y = 0
	drifter.velocity.x = 0
	target = get_tree().get_first_node_in_group("Player")

func _update(_delta : float):
	wait -= _delta
	dashTime -= _delta
	
	if dashTime > 0:
		drifter.speed = 600
	else:
		drifter.velocity.y = 0
		drifter.velocity.x = 0
		drifter.speed = 0
	
	if wait <= 0 and distance.length() < 300:
		_dash()
		if target != null:
			drifter.direction = sign(target.global_position.x - drifter.global_position.x)
		else: pass
		drifter.speed = 200
		drifter.velocity = angle * drifter.speed
		dashTime = .40
		wait = 1.0
	
	if target != null:
		distance = target.global_position - drifter.global_position
	else:
		pass
	
	if distance.length() > 300 and wait <- 0:
		state_transition.emit(self, "drifter_wander")

func _exit():
	pass

func _dash():
	if target != null:
		angle = (target.global_position - drifter.global_position).normalized()
	else:
		pass
