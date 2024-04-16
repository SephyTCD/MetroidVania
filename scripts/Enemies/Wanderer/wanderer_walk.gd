extends WandererState
class_name wanderer_walk

var distance = 0
var target = null
var walkTime = 3
var edgeDetect = null

func _enter():
	
	$"../../walkSight"/CollisionShape2D.set_deferred("disabled", false)

	
	if wanderer.direction > 0:
		edgeDetect = %edge_detect_right
	if wanderer.direction < 0:
		edgeDetect = %edge_detect_left
	wanderer.speed = 40
	target = get_tree().get_first_node_in_group("Player")
	
func _update(_delta : float):
	
	#if edgeDetect == %edge_detect_right:
		#print("right")
	#if edgeDetect == %edge_detect_left:
		#print("left")
	
	if wanderer.direction == -1 and wanderer.speed != 0:
		wanderer.animations.play("wanderer_trot")
		wanderer.sprite.flip_h = false
	if wanderer.direction == 1 and wanderer.speed != 0:
		wanderer.animations.play("wanderer_trot")
		wanderer.sprite.flip_h = true
	
	walkTime -= _delta
	
	if walkTime <= 0 or edgeDetect.is_colliding() == false or wanderer.is_on_wall():
		_change_direction()
		walkTime = 3

	if target != null:
		distance = target.global_position - wanderer.global_position
	else:
		pass

	#if distance.length() < 180:
		#state_transition.emit(self, "wanderer_chase")

func _exit():
	pass

func _change_direction():
	wanderer.direction *= -1
	if wanderer.direction > 0:
		edgeDetect = %edge_detect_right
	if wanderer.direction < 0:
		edgeDetect = %edge_detect_left




func _on_walk_sight_body_entered(body):
	if body == target:
		state_transition.emit(self, "wanderer_chase")
