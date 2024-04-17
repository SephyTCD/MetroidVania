extends CanisState
class_name canis_neutral

var moveOffset = 1
var moveTime = 1
var target = null
var switch = 9
var switchTime = .6
var secondaryTime = .1
var fuck = .5

var anim = "canis_walk"

func _enter():
	target = get_tree().get_first_node_in_group("Player")
	canis.speed = 40
	moveTime = 1
	switchTime = 1
	secondaryTime = .1
	switch = 9

func _update(_delta : float):
	
	if canis.is_on_floor() == false:
		anim = "canis_air"
		canis.velocity.x = 0
	if canis.is_on_floor() == true:
		canis.velocity.x = canis.speed * moveOffset
		anim = "canis_walk"

	
	if canis.direction == -1:
		canis.animations.play(anim)
		canis.sprite.flip_h = false
	if canis.direction == 1:
		canis.animations.play(anim)
		canis.sprite.flip_h = true
	
#//////////////////////////////////////////////////////////////////////
	
	if moveTime > 0:
		moveTime -= _delta
	
	if fuck > 0:
		fuck -= _delta
	
	if moveTime <= 0 or canis.is_on_wall() and fuck <= 0:
		moveOffset *= -1
		moveTime = 1
		fuck = .5

	
	if target != null:
		canis.direction = sign(target.global_position.x - canis.global_position.x)
	else:
		pass

#//////////////////////////////////////////////////////////////////////

	if switchTime > 0:
		switchTime -= _delta

	if switchTime <= 0 and switch == 9:
		switch = randi_range(0,8)

	if switchTime <= 0 and switch == 0:
		switchTime = .6
		switch = 9

#/////////////

	if switchTime <= 0 and switch == 1 or switchTime <= 0 and switch == 2 or switchTime <= 0 and switch == 3:
		state_transition.emit(self, "canis_run")

#/////////////

	if switchTime <= 0 and switch == 4:
		state_transition.emit(self, "canis_shoot")

#/////////////

	if switchTime <= 0 and switch == 5 or switchTime <= 0 and switch == 6 or switchTime <= 0 and switch == 7:
		
		if canis.direction == -1:
			canis.animations.play("canis_squat")
			canis.sprite.flip_h = false
		if canis.direction == 1:
			canis.animations.play("canis_squat")
			canis.sprite.flip_h = true
		
		canis.velocity.x = 0
		
		if secondaryTime > 0:
			secondaryTime -= _delta
		
		if secondaryTime <= 0:
			state_transition.emit(self, "canis_airshoot")

#///////////////

	if switchTime <= 0 and switch == 8:
		
		if canis.direction == -1:
			canis.animations.play("canis_squat")
			canis.sprite.flip_h = false
		if canis.direction == 1:
			canis.animations.play("canis_squat")
			canis.sprite.flip_h = true
		
		canis.velocity.x = 0
		
		if secondaryTime > 0:
			secondaryTime -= _delta
		
		if secondaryTime <= 0:
			state_transition.emit(self, "canis_jump")

func _exit():
	pass

func _sound():
	$"../../sounds/stomp".play()
