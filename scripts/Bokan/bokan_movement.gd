extends State
class_name Moving

func _physics_update(_delta : float):

	if player.moveLock <= 0:
		player.speed = 250
		player.velocity.x = player.direction * player.speed
