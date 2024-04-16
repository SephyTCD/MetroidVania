extends CanisState
class_name canis_wake

var sparkOffsetx = 0
var sparkOffsety = 0
var sparkTrigger = 0
var sparkDelay = 2
var distance = 0
var target = null

var anim = "canis_sleep"

var bullet = preload("res://scenes/Entities/enemies/wake_spark.tscn")

func _enter():
	target = get_tree().get_first_node_in_group("Player")

func _update(_delta : float):
	
	if sparkTrigger == 0:
		anim = "canis_sleep"
	if sparkTrigger == 1 or sparkTrigger == 2:
		anim = "canis_wake"
	
	canis.animations.play(anim)
	
	
	if target != null:
		distance = target.global_position - canis.global_position
	else:
		pass
	
	if distance.length() < 200 and sparkTrigger != 2:
		_sparks_start()
	
	if sparkDelay > 0 and sparkTrigger == 1:
		sparkDelay -= _delta
		sparkOffsetx = randi_range(-40, 40)
		sparkOffsety = randi_range(-40, 40)
	
	if sparkTrigger == 1 and sparkDelay <= 0:
		var inst = bullet.instantiate()
		get_tree().current_scene.add_child(inst)
		inst.global_position = canis.global_position + Vector2(sparkOffsetx, sparkOffsety)
		sparkDelay = .05

func _exit():
	Globals.inCutscene = false

func _end():
	state_transition.emit(self, "canis_neutral")

func _sparks_start():
	sparkTrigger = 1

func _sparks_end():
	sparkTrigger = 2

func _freeze():
	Globals.inCutscene = true
