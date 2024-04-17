extends AlandraState
class_name alandra_leaving

var leaveTime = .50

func _enter():
	leaveTime = .50
	alandra.direction = 1
	alandra.jumpSpeed = alandra.jumpForce
	alandra.velocity.y = alandra.jumpSpeed

func _update(_delta : float):
	
	if alandra.is_on_floor() == false:
		if alandra.direction == 1:
			alandra.animations.play("alandra_jump")
			alandra.sprite.flip_h = false
		if alandra.direction == -1:
			alandra.animations.play("alandra_jump")
			alandra.sprite.flip_h = true
	
	if alandra.is_on_floor() == true:
		if alandra.direction == 1:
			alandra.animations.play("alandra_idle")
			alandra.sprite.flip_h = false
		if alandra.direction == -1:
			alandra.animations.play("alandra_idle")
			alandra.sprite.flip_h = true
	
	if alandra.is_on_floor() == true and alandra.velocity.x != 0:
		if alandra.direction == 1:
			alandra.animations.play("alandra_run")
			alandra.sprite.flip_h = false
		if alandra.direction == -1:
			alandra.animations.play("alandra_run")
			alandra.sprite.flip_h = true
	
	alandra.velocity.x = 400
	
	
	leaveTime -= _delta

	if leaveTime <= 0:
		alandra.despawn = 1

func _exit():
	pass
	
