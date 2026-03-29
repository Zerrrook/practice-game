extends PlayerState
class_name PlayerJump

@export var run_state : State
@export var idle_state : State
@export var hurt_state : State

@onready var jump_sound: AudioStreamPlayer2D = $"../../Sounds/JumpSound"

func enter(): # Ignore hit_data
	super()
	_jump()

func process_physics(delta: float):
	
	if player.pending_hit:
		return hurt_state
		
	player.velocity.y += gravity * delta
	
	movement = Input.get_axis("move_left", "move_right") * speed
	
	if movement != 0:
		player.animated_sprite.flip_h = movement < 0
	player.velocity.x = movement
	player.move_and_slide()

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

	
