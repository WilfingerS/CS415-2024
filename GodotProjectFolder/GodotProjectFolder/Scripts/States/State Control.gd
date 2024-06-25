extends Node

@export var initial_state : State

var states : Dictionary = {}
var current_state : State

func _ready():
	for child in get_children():
		if child is State:
			states[child.name] = child
			child.ChangeState.connect(state_change)
	
	if initial_state:
		initial_state.Enter()
		current_state = initial_state

func _process(delta):
	if current_state:
		current_state.Update(delta)

func _physics_process(delta):
	if current_state:
		current_state.Physics_Update(delta)
		
func state_change(state, new_state_name):
	if state != current_state:
		return
		
	var new_state = states.get(new_state_name)
	if !new_state:
		return
	
	if current_state:
		current_state.Exit()
		
	new_state.Enter()
	
	current_state = new_state
