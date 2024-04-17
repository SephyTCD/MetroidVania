extends AlandraState
class_name alandra_shocked

func _enter():
	pass

func _update(_delta : float):

	if alandra.direction == 1:
		alandra.animations.play("alandra_surprise")
		alandra.sprite.flip_h = false
	if alandra.direction == -1:
		alandra.animations.play("alandra_surprise")
		alandra.sprite.flip_h = true
	

func _exit():
	pass
	
