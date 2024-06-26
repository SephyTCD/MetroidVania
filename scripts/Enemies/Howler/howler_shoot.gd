extends HowlerState
class_name howler_shoot

var time =  0.0
var limit = 0
var target = null
var distance = 0

var bullet = preload("res://scenes/Entities/enemies/howler_projectile.tscn")
@export var marker : Marker2D

func _enter():
	target = get_tree().get_first_node_in_group("Player")
	time = 0.0
	limit = 0

func _update(_delta : float):
	if howler.direction == -1:
		howler.animations.play("howler_shoot")
		howler.sprite.flip_h = false
	if howler.direction == 1:
		howler.animations.play("howler_shoot")
		howler.sprite.flip_h = true

	if target != null:
		distance = target.global_position - howler.global_position
	else:
		pass


	time -= _delta
	
	if time < 0:
		var inst = bullet.instantiate()
		get_parent().add_child(inst)
		inst.global_position = marker.global_position
		if howler.direction == -1:
			inst.speed *= -1
			inst.direction = 1
			inst.time = howler.projTime
		if howler.direction == 1:
			inst.speed *= 1
			inst.direction = -1
			inst.time = howler.projTime
		time = 0.35
		limit += 1

		if distance.length() < 300:
			$"../../shoot".play()

	if limit == 3:
		state_transition.emit(self, "howler_idle")

func _exit():
	pass
