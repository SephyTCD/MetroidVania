extends CanisState
class_name canis_airshoot

var airTime = .50
var endAble = 0
var limit = 0

var anim = "canis_jump"

var bullet = preload("res://scenes/Entities/enemies/lost_envoy_canis_projectile.tscn")
@export var marker : Marker2D

func _enter():
	canis.velocity.y = -200
	airTime = .50
	endAble = 0
	limit = 0

func _update(_delta : float):
	if canis.velocity.y < 0:
		anim = "canis_jump"
	if canis.velocity.y == 0:
		anim = "canis_airshot"

	if canis.direction < 0:
		canis.marker.position.x = abs(canis.marker.position.x) * -1

	if canis.direction > 0:
		canis.marker.position.x = abs(canis.marker.position.x) * 1

	if canis.direction == -1:
		canis.animations.play(anim)
		canis.sprite.flip_h = false
	if canis.direction == 1:
		canis.animations.play(anim)
		canis.sprite.flip_h = true

	if canis.velocity.y >= 0 and airTime > 0:
		airTime -= _delta
		canis.velocity.y = 0
		canis.gravity = 0

		if limit == 0:
			var inst = bullet.instantiate()
			get_tree().current_scene.add_child(inst)
			inst.global_position = canis.marker.global_position
			if canis.marker.position.x > 0:
				inst.speed *= 1
			if canis.marker.position.x < 0:
				inst.speed *= -1
			limit = 1

	if airTime <= 0:
		canis.gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
		state_transition.emit(self, "canis_neutral")

func _exit():
	pass

func _sound():
	$"../../sounds/projectile".play()
