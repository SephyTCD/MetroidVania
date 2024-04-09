extends WandererState
class_name wanderer_chase

var distance = 0
var target = null
var edgeDetect = null
var anim = "wanderer_trot"

func _enter():
	wanderer.speed = 150
	
	target = get_tree().get_first_node_in_group("Player")
	
	if target != null:
		wanderer.direction = sign(target.global_position.x - wanderer.global_position.x)
	else:
		pass

	if wanderer.direction > 0:
		edgeDetect = %edge_detect_right
	if wanderer.direction < 0:
		edgeDetect = %edge_detect_left

func _update(_delta : float):

	#if edgeDetect == %edge_detect_right:
		#print("right")
	#if edgeDetect == %edge_detect_left:
		#print("left")

	
	if wanderer.velocity.x == 0:
		anim = "wanderer_idle"
	else:
		anim = "wanderer_trot"
	
	if wanderer.direction == -1 and wanderer.speed != 0:
		wanderer.animations.play(anim)
		wanderer.sprite.flip_h = false
	if wanderer.direction == 1 and wanderer.speed != 0:
		wanderer.animations.play(anim)
		wanderer.sprite.flip_h = true
	
	if target != null:
		distance = target.global_position - wanderer.global_position
	else:
		pass
	
	if target != null:
		wanderer.direction = sign(target.global_position.x - wanderer.global_position.x)
	else:
		pass
	
	if edgeDetect.is_colliding() == false:
		wanderer.speed = 0
		wanderer.velocity.x = 0

	
	if distance.length() < 50:
		state_transition.emit(self, "wanderer_attack")
	
	if distance.length() > 250:
		state_transition.emit(self, "wanderer_walk")

func _exit():
	pass
