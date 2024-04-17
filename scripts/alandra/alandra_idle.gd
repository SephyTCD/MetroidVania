extends AlandraState
class_name alandra_idle

var distance = 0

func _enter():
	pass

func _update(_delta : float):
	
	if alandra.direction == 1:
		alandra.animations.play("alandra_idle")
		alandra.sprite.flip_h = false
	if alandra.direction == -1:
		alandra.animations.play("alandra_idle")
		alandra.sprite.flip_h = true

	if alandra.trigger == 1 and alandra.event == 1:
		state_transition.emit(self, "alandra_talking")

	if alandra.trigger == 1 and alandra.event == 3:
		state_transition.emit(self, "alandra_talking")

	if alandra.trigger == 1 and alandra.event == 2:
		state_transition.emit(self, "alandra_shocked")

func _exit():
	pass

