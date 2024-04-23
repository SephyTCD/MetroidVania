extends State
class_name bokan_damage

var time = .25

func _enter():
	$"../../sounds/damage".play()
	player.invTime = 1
	player.shootLock = 1
	time = .25
	player.velocity.x = player.knockForce * player.knockBack
	player.velocity.y = player.knockUp

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

	if Globals.health <= 0:
		state_transition.emit(self, "bokan_death")

func _exit():
	player.knockForce = 200
	player.knockUp = -200
	player.velocity.x = 0
	player.velocity.y = 0
	player.invTime = 1
	player.shootLock = 0
