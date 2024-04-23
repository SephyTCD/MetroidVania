extends State
class_name bokan_wall_slide

var animLock = 0
var anim = "wall_slide"
var wallDetect = null
var wallDetectLow = null
var hangTime = .07

func _enter():
	animLock = 0
	player.runLock = 0
	player.velocity.y = 100
	player.gravity = 100
	hangTime = .07

func _update(_delta : float):
#//////////////////////////////////////////////////////////////////////////////
	#animations
	
	#print("slide")

	if Input.is_action_just_pressed("shoot"):
		animLock = 1

	if animLock == 1:
		anim = "wall_throw"
	else:
		anim = "wall_slide"

	if player.facing == -1:
		player.animations.play(anim)
		player.sprite.flip_h = false
	if player.facing == 1:
		player.animations.play(anim)
		player.sprite.flip_h = true

	if player.facing == 1:
		wallDetect = $"../../on_wall_right"
	if player.facing == -1:
		wallDetect = $"../../on_wall_left"

	if player.facing == 1:
		wallDetectLow = $"../../on_wall_right_low"
	if player.facing == -1:
		wallDetectLow = $"../../on_wall_left_low"

#//////////////////////////////////////////////////////////////////////////////
	#Transitions

	if Input.is_action_pressed("ui_left") == false and player.facing == -1 or Input.is_action_pressed("ui_right") == false and player.facing == 1:
		hangTime -= _delta
	else:
		hangTime = .07

	if wallDetect.is_colliding() == true:
		$"../../on_wall_right_low".set_deferred("disabled", true)
		$"../../on_wall_left_low".set_deferred("disabled", true)

	if wallDetect.is_colliding() == false and wallDetectLow.is_colliding() == false or hangTime <= 0:
		state_transition.emit(self, "bokan_air")

	if player.is_on_floor():
		player.velocity.y = 0
		state_transition.emit(self, "bokan_idle")

	elif Input.is_action_just_pressed("jump") or player.jumpBuff > 0:
		state_transition.emit(self, "bokan_wall_jump")

	#elif player.damaged == 1:
		#state_transition.emit(self, "bokan_damage")

	if player.health <= 0:
		state_transition.emit(self, "bokan_death")

func _exit():
	player.animLock = 0
	player.runLock = 0
	player.gravity = 1800
	player.facing *= -1
	player.marker.position.x *= -1

func _anim_unlock():
	animLock = 0
