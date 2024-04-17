extends AlandraState
class_name alandra_talking

var talkTime = .35

func _enter():
	Globals.inCutscene = true
	talkTime = .35

func _update(_delta : float):
	
	if alandra.direction == 1:
		alandra.animations.play("alandra_idle")
		alandra.sprite.flip_h = false
	if alandra.direction == -1:
		alandra.animations.play("alandra_idle")
		alandra.sprite.flip_h = true
	


	talkTime -= _delta
	
	if talkTime <= 0:
		state_transition.emit(self, "alandra_leaving")
	
func _exit():
	pass


