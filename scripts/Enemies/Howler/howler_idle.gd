extends HowlerState
class_name howler_idle

var time = 2
var target = null

func _enter():
	time = 2
	target = get_tree().get_first_node_in_group("Player")

func _update(_delta : float):
	time -= _delta
	
	if howler.direction == -1:
		howler.animations.play("howler_idle")
		howler.sprite.flip_h = false
	if howler.direction == 1:
		howler.animations.play("howler_idle")
		howler.sprite.flip_h = true

	if time < 0:
		state_transition.emit(self, "howler_shoot")

func _exit():
	pass
