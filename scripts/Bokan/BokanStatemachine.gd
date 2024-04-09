extends Node
class_name StateMachine

var states : Dictionary = {}
var current_state : State
@export var initial_state : State
@export var player : Player

func _ready():
	for child in get_children():
		if child is State:
			child.player = player
			child.stateMachine = self
			states[child.name.to_lower()] = child
			child.state_transition.connect(change_state)

	if initial_state:
		initial_state._enter()
		current_state = initial_state

func _process(_delta):
	if (Globals.checkForCutsceneFreeze()): # freeze if in cutscene
		return
	
	if current_state:
		current_state._update(_delta)

func change_state(source_state : State, new_state_name : String):
	if (Globals.checkForCutsceneFreeze()): # freeze if in cutscene
		return
	
	if source_state != current_state:
		print("invalid " + source_state.name + " currently " + current_state.name)
		return

	var new_state = states.get(new_state_name.to_lower())
	if !new_state:
		print("New state is empty")
		return

	if current_state:
		current_state._exit()

	new_state._enter()
	
	current_state = new_state
