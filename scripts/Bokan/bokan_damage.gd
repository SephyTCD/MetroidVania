extends State
class_name bokan_damage

var time = .25

func _enter():
	player.invTime = 1

	time = .25
	player.velocity.x = 200 * player.knockBack
	player.velocity.y = -200

func _update(_delta : float):
#//////////////////////////////////////////////////////////////////////////////
	#animations
	
	if player.velocity.x > 0 and player.animLock == 0:
		player.animations.play("damage")
		player.sprite.flip_h = true
	if player.velocity.x < 0 and player.animLock == 0:
		player.animations.play("damage")
		player.sprite.flip_h = false
	
	player.modulate.a = 0.5

#//////////////////////////////////////////////////////////////////////////////
	#Transitions

	time -= _delta

	if time <= 0:
		state_transition.emit(self, "bokan_idle")

func _exit():
	player.velocity.x = 0
	player.velocity.y = 0
	player.damaged = 0
	player.invTime = 1
