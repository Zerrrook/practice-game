extends PlayerState
class_name PlayerRun

@export var idle_state : State
@export var jump_state : State
@export var hurt_state : State

func process_input(_event : InputEvent):
	if Input.is_action_just_pressed("jump") and (!player.coyote_timer.is_stopped() or player.is_on_floor()):
		# Go to the jump state when player pressed jumped and is on the floor or coyote time is still going.
		return jump_state 

func process_physics(delta: float):
	
	# Goes to the hit state if the player detects a hit
	if player.pending_hit:
		return hurt_state 
	
	# Coyote time gives leniency and fairness to the player
	_coyote_timing()  
	player.velocity.y += gravity * delta
	
	movement = Input.get_axis("move_left", "move_right") * speed
	
	if movement == 0:
		return idle_state # If not moving, go to idle state
	
	player.animated_sprite.flip_h = movement < 0 
	player.velocity.x = movement
	player.move_and_slide()
	
	return null

func _coyote_timing():
	if player.is_on_floor():
#		Makes sure that the Coyote timer is not activated when touching the floor
		if coyote_timer_activated:
			coyote_timer_activated = false
			player.coyote_timer.stop()
	else:
#		Makes sure that the Coyote timer IS activated when not touching the floor
		if !coyote_timer_activated:
			player.coyote_timer.start()
			coyote_timer_activated = true
