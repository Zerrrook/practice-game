extends PlayerState
class_name PlayerJump

@export var run_state : State
@export var idle_state : State
@export var hurt_state : State

@onready var jump_sound: AudioStreamPlayer2D = $"../../Sounds/JumpSound"

func enter(): # Ignore hit_data
	super()
	_jump()

func process_physics(_delta: float):
	movement = player.move_component.get_movement_direction() * speed
	
	if movement != 0:
		animation_flipping(movement)

	player.velocity.x = movement
	apply_gravity_and_move(_delta)

	if player.is_on_floor():
		if movement != 0:
			return run_state
		return idle_state
		
	return null
	
func _jump():
	player.velocity.y = -jump_velocity
	jump_sound.play()
	
#	After jumping, reset the Coyote timer.
	player.coyote_timer.stop()
	coyote_timer_activated = true

	
