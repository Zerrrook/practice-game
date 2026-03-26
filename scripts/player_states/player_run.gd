extends PlayerState
class_name PlayerRun

func Enter(_hit_data : Dictionary = {}): # Ignore hit data
	animated_sprite.play("run")

func Physics_Update(_delta: float):
	gravity(_delta)
#	Disables movement when player dies
	if !is_alive:
		player.move_and_slide()
		return
#	Sets the player's velocity to 0 after dying state
	if !dying:
		movement()
	else:
		player.velocity.x = 0
	
	if !is_hurt: 
		handle_animation() # Prevents other animation overriding hurt animation
		_coyote_timing() # Implements Coyote Timing 
		
	if Input.is_action_just_pressed("jump") and (!coyote_timer.is_stopped() or player.is_on_floor()):
		state_transition.emit(self, "jump")
	
func _coyote_timing():
	if player.is_on_floor():
#		Makes sure that the Coyote timer is not activated when touching the floor
		if coyote_timer_activated:
			coyote_timer_activated = false
			coyote_timer.stop()
	else:
#		Makes sure that the Coyote timer IS activated when not touching the floor
		if !coyote_timer_activated:
			coyote_timer.start()
			coyote_timer_activated = true

func _on_hit(hit_data: Variant) -> void:
	if is_hurt: # Player can't get hit again when they're hit
		return
	
	state_transition.emit(self, "hurt", hit_data)
