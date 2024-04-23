extends TutorialState
class_name tutorial_hidden

var target = null

func _enter():
	tutorial.hide = 0
	Globals.inCutscene = false

func _update(_delta : float):
	target = get_tree().get_first_node_in_group("Player")

func _exit():
	pass

func _on_area_2d_body_entered(body):
	if body == target and tutorial.active == 0:
		state_transition.emit(self, "tutorial_show")
