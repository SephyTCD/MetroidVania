extends CharacterBody2D

func _physics_process(delta):
	if Globals.inCutscene: # Prevent physics update when in cutscene
		return 

	move_and_slide()

func _crush():
	queue_free()
