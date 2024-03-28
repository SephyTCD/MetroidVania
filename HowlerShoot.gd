extends HowlerState
class_name HowlerShoot

var time = 0.0
var limit = 0

var bullet = preload("res://howler_projectile.tscn")
@export var marker : Marker2D

func _enter():
	limit = 0

func _update(_delta : float):
	howler.animations.play("shoot")
	time -= _delta
	
	if time < 0:
		var inst = bullet.instantiate()
		get_parent().add_child(inst)
		inst.global_position = marker.global_position
		if howler.direction == -1:
			inst.speed *= -1
		if howler.direction == 1:
			inst.speed *= 1
		time = 0.35
		limit += 1

	if limit == 3:
		state_transition.emit(self, "HowlerIdle")

	if howler.direction == -1:
		howler.animations.play("shoot")
		howler.sprite.flip_h = false
	if howler.direction == 1:
		howler.animations.play("shoot")
		howler.sprite.flip_h = true

func _exit():
	pass
