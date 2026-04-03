extends PlayerState
class_name PlayerJump

@export var run_state : State
@export var idle_state : State

@onready var jump_sound: AudioStreamPlayer2D = $"../../Sounds/JumpSound"

func enter(): # Ignore hit_data
	super()
	_jump()

func process_physics(_delta: float):
	
	# Allows movement when jumping
	direction = player.move_component.get_movement_direction() * player.speed
	if direction != 0:
		animation_flipping(direction)

	player.velocity.x = direction
	apply_gravity_and_move(_delta)
	
	if player.is_on_floor(): # Return to either idle or run state depending on movement
		if direction != 0:
			run_state.previous_direction = direction
			return run_state
		return idle_state
		
	return null
	

func _jump():
	player.velocity.y = -player.jump_velocity
	jump_sound.play()
	
#	After jumping, reset the Coyote timer.
	player.coyote_timer.stop()
	player.coyote_timer_activated = true
