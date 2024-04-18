extends CanisState
class_name canis_death

var sparkOffsetx = 0
var sparkOffsety = 0
var time = 4
var anim = null
var sparkDelay = 2

var bullet = preload("res://scenes/misc/deathspark.tscn")

func _enter():
	time = 4
	canis.velocity.x = 0
	canis.velocity.y = 0
	canis.gravity = 0

func _update(_delta : float):
	
	print(time)
	
	if canis.is_on_floor():
		anim = "canis_still"
	if canis.is_on_floor() == false:
		anim = "canis_air"
	
	
	if canis.direction == -1:
		canis.animations.play(anim)
		canis.sprite.flip_h = false
	if canis.direction == 1:
		canis.animations.play(anim)
		canis.sprite.flip_h = true

	time -= _delta
	
	if sparkDelay > 0 and time < 4:
		sparkDelay -= _delta
		sparkOffsetx = randi_range(-40, 40)
		sparkOffsety = randi_range(-40, 40)

	

	if time < 3 and sparkDelay <= 0:
		var inst = bullet.instantiate()
		get_tree().current_scene.add_child(inst)
		inst.global_position = canis.global_position + Vector2(sparkOffsetx, sparkOffsety)
		sparkDelay = .2

	if time <= 0:
		canis.dying = 1

func _exit():
	pass
