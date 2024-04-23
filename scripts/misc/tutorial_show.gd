extends TutorialState
class_name tutorial_show

var pressBuff = .15
var target = null

func _enter():
	Globals.inCutscene = true
	tutorial.hide = 1
	tutorial.active = 1

func _update(_delta : float):
	
	target = get_tree().get_first_node_in_group("Player")

	tutorial.global_position = target.global_position + Vector2(0, -10)

	pressBuff -= _delta

	if Input.is_action_just_pressed("shoot") and pressBuff < 0 or Input.is_action_just_pressed("jump") and pressBuff < 0:
		state_transition.emit(self, "tutorial_hidden")

func _exit():
	pass
