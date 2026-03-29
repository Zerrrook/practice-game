extends PlayerState
class_name PlayerIdle

@export var run_state : State
@export var jump_state : State
@export var hurt_state : State

func enter(): # Ignore hit_data
	super()
	player.velocity.x = 0

func process_input(_event : InputEvent):
	if player.move_component.get_movement_direction():
		return run_state # Go to the run state when player moves
	if player.move_component.wants_jump() and player.is_on_floor():
		return jump_state # Go to the jump state when player jumps and is not on the floor

func process_physics(_delta: float):
	apply_gravity_and_move(_delta)
	
	return null
	
