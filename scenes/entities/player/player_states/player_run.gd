extends PlayerState
class_name PlayerRun

@export var idle_state : State
@export var jump_state : State

var previous_direction : float

func process_input(_event : InputEvent):
	if player.move_component.wants_jump() and (!player.coyote_timer.is_stopped() or player.is_on_floor()):
		# Go to the jump state when player pressed jumped and is on the floor or coyote time is still going.
		return jump_state 

func process_physics(_delta: float):
	# Coyote time gives leniency and fairness to the player
	_coyote_timing()  
	
	direction = player.move_component.get_movement_direction() * player.speed 
	if direction == 0:
		return idle_state # If not moving, go to idle state
	
	if direction != previous_direction:
		if previous_direction != 0:
			player.animated_sprite.play("turn")
	previous_direction = direction
	
	animation_flipping(direction)
	
	player.velocity.x = direction
	apply_gravity_and_move(_delta)
	
	return null

func _coyote_timing():
	if player.is_on_floor():
#		Makes sure that the Coyote timer is not activated when touching the floor
		if player.coyote_timer_activated:
			player.coyote_timer_activated = false
			player.coyote_timer.stop()
	else:
#		Makes sure that the Coyote timer IS activated when not touching the floor
		if !player.coyote_timer_activated:
			player.coyote_timer.start()
			player.coyote_timer_activated = true

func _on_animation_finished() -> void:
	if player.animated_sprite.animation == "turn":
		player.animated_sprite.play(animation_name)
