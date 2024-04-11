extends Node
class_name ProvocatorStatemachine

var states : Dictionary = {}
var current_state : ProvocatorState
@export var initial_state : ProvocatorState
@export var provocator : Provocator

func _ready():
	for child in get_children():
		if child is ProvocatorState:
			child.provocator = provocator
			child.stateMachine = self
			states[child.name.to_lower()] = child
			child.state_transition.connect(change_state)

	if initial_state:
		initial_state._enter()
		current_state = initial_state

func _process(delta):
	if (Globals.checkForCutsceneFreeze()): # freeze if in cutscene
		return
	
	if current_state:
		current_state._update(delta)

func change_state(source_state : ProvocatorState, new_state_name : String):
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
