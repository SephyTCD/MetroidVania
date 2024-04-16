extends bossdoorState
class_name bossdoor_active

func _enter():
	pass

func _update(_delta : float):
	bossdoor.animations.play("pulse")

func _exit():
	pass
