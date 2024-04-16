extends CanisState
class_name canis_shoot

var time = .50

var bullet = preload("res://scenes/Entities/enemies/lost_envoy_canis_projectile.tscn")
@export var marker : Marker2D

func _enter():
	canis.velocity.x = 0
	canis.speed = 0
	time = .50

	if canis.direction < 0:
		canis.marker.position.x = abs(canis.marker.position.x) * -1

	if canis.direction > 0:
		canis.marker.position.x = abs(canis.marker.position.x) * 1

	var inst = bullet.instantiate()
	get_tree().current_scene.add_child(inst)
	inst.global_position = canis.marker.global_position
	if canis.marker.position.x > 0:
		inst.speed *= 1
	if canis.marker.position.x < 0:
		inst.speed *= -1

func _update(_delta : float):
	
	if canis.direction == -1:
		canis.animations.play("canis_shot")
		canis.sprite.flip_h = false
	if canis.direction == 1:
		canis.animations.play("canis_shot")
		canis.sprite.flip_h = true

	if time > 0:
		time -= _delta

	if time <= 0:
		state_transition.emit(self, "canis_neutral")

func _exit():
	pass
