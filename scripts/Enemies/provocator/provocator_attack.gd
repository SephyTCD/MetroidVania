extends ProvocatorState
class_name provocator_attack

var target = null

var bullet = preload("res://scenes/Entities/enemies/provocator_rock.tscn")
@export var marker : Marker2D

func _enter():
	target = get_tree().get_first_node_in_group("Player")
	if target != null:
		provocator.direction = sign(target.global_position.x - provocator.global_position.x)
	else:
		pass

func _update(_delta : float):
	if provocator.direction == -1:
		provocator.animations.play("provocator_throw")
		provocator.sprite.flip_h = false
	if provocator.direction == 1:
		provocator.animations.play("provocator_throw")
		provocator.sprite.flip_h = true

func _exit():
	provocator.transTime = .8
	

func _shoot():
	var inst = bullet.instantiate()
	get_tree().current_scene.add_child(inst)
	inst.global_position = marker.global_position
	if target != null:
		inst.velocity = ((target.global_position - inst.global_position).normalized() * inst.speed)
	else:
		pass
	if provocator.direction == -1:
		inst.speed *= -1
		inst.direction = -1
	if provocator.direction == 1:
		inst.speed *= 1
		inst.direction = 1


func _end():
	state_transition.emit(self, "provocator_idle")
