extends PlayerState
class_name PlayerIdle

@export var run_state : State
@export var jump_state : State
@export var hurt_state : State

func enter(): # Ignore hit_data
	super()
	player.velocity.x = 0

func process_input(_event : InputEvent):
	if Input.get_axis("move_left", "move_right"):
		return run_state # Go to the run state when player moves
	if Input.is_action_just_pressed("jump") and player.is_on_floor():
		return jump_state # Go to the jump state when player jumps and is not on the floor

func process_physics(delta: float):
	
	# Goes to the hit state if the player detects a hit
	if player.pending_hit:
		return hurt_state
	
	player.velocity.y += gravity * delta
	player.move_and_slide()
	
	return null
	
