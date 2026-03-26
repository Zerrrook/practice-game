extends Node

@export var initial_state : State

var current_state : State
var states : Dictionary = {}

func _ready() -> void:
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.state_transition.connect(_on_state_transitioned)
	
	if initial_state:
		initial_state.Enter()
		current_state = initial_state
func _process(delta: float) -> void:
	if current_state:
		current_state.Update(delta)
func _physics_process(delta: float) -> void:
	if current_state:
		current_state.Physics_Update(delta)
	
func _on_state_transitioned(source_state: State, new_state_name: String, hit_data : Dictionary = {}):
	if source_state != current_state:
		return
		
	var new_state: State = states.get(new_state_name.to_lower())
	if !new_state:
		return
		
	if new_state == current_state:
		return
	
	if current_state:
		current_state.Exit()
	
	new_state.Enter(hit_data)
	
	current_state = new_state
	
