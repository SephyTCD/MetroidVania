extends AlandraState
class_name alandra_demoend

var target = null

var text = preload("res://scenes/misc/thanks_for_playing.tscn")

func _enter():
	target = get_tree().get_first_node_in_group("Player")

func _update(_delta : float):
	
	var inst = text.instantiate()
	get_tree().current_scene.add_child(inst)
	inst.global_position = target.global_position + Vector2(-120, -120)
	
	if Input.is_action_just_pressed("jump") or Input.is_action_just_pressed("shoot"):
		Globals.inCutscene = false
		Globals.maxHealth = 10
		CheckPoint.lastPose = null
		get_tree().change_scene_to_file("res://scenes/misc/introcutscene.tscn")

func _exit():
	pass
	
