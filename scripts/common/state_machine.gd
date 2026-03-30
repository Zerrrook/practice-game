extends Node

@export var initial_state : State

var current_state : State
var owner_parent
# Initializes the state machine by giving each child state a reference to the parent
func init(parent):
	self.owner_parent = parent
	for child in get_children():
		if child is State:
			child.parent = parent
		
	change_state(initial_state)
func change_state(new_state: State):
	if current_state:
		current_state.exit() 
	
	# Gets assigned to the new state after exiting then enter as that state
	current_state = new_state 
	current_state.enter()


#region Pass through functions for the parent to call, also handles state changes as needed
func process_input(event: InputEvent):
	var new_state = current_state.process_input(event)
	if new_state:
		change_state(new_state)

func process_physics(delta: float):
	
	if owner_parent.has_method("get_global_state"):
		var forced_state = owner_parent.get_global_state()
		if forced_state:
			change_state(forced_state)
			return
	var new_state = current_state.process_physics(delta)
	if new_state:
		change_state(new_state)
	
func process_frame(delta: float):
	var new_state = current_state.process_frame(delta)
	if new_state:
		change_state(new_state)
#endregion
