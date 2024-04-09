extends Node

var inCutscene = false # If true, everything freezes except for relevant cutscene stuff

# Called when the node enters the scene tree for the first time.
func _ready():
	inCutscene = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	# Debug functions for cutscene starting and stopping
	if Input.is_key_pressed(KEY_Q):
			inCutscene = true
			print("cutscene started")
			
	if Input.is_key_pressed(KEY_W):
		inCutscene = false
		print("cutscene ended")
		
	if Input.is_key_pressed((KEY_R)):
			print(inCutscene)
		
func checkForCutsceneFreeze():
	if (inCutscene == true):
		return true
	else:
		return false
