extends PlayerState
class_name PlayerJump

@onready var jump_sound: AudioStreamPlayer2D = $"../../Sounds/JumpSound"

func Enter(_hit_data : Dictionary = {}): # Ignore hit data
	animated_sprite.play("jump")
	_jump()

func Physics_Update(_delta: float):
	if !player.is_on_floor():
		gravity(_delta)
	else:
		state_transition.emit(self, "run")
	movement() # Allows to move while mid-air
	handle_animation()

func _jump():
	player.velocity.y = jump_velocity
	jump_sound.play()
	
#	After jumping, reset the Coyote timer.
	coyote_timer.stop()
	coyote_timer_activated = true
