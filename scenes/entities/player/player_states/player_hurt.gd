extends PlayerState
class_name PlayerHurt

@onready var hurt_sound: AudioStreamPlayer2D = $"../../Sounds/HurtSound"

@export var run_state : State
@export var dead_state : State
@export var respawn_state : State

var fallback_respawn := false
var duration := 0.12
var timer := 0.0

func enter():
	super()
	fallback_respawn = false
	
	hurt_sound.play()
	timer = duration # I forgot but this is crucial I promise
	
	var damage_data = player.pending_damage # Get damage data from the pending damage
	player.pending_damage = {} # Clears pending damage for the next damage
	
	var is_hazard = damage_data.get("is_hazard", false) # Transfer the value from the dictionary
	
	# Send damage data to the health component
	player.player_health_component.damage_taken(damage_data["damage"]) 
	
	if is_hazard: # Applies logic when the damage source is a hazard
		fallback_respawn = true
		if !player.dying:
			TransitionScreen.transition()
			await TransitionScreen.on_transitioned_finished
			player.position = CheckpointManager.fallback_position
			player.velocity = Vector2.ZERO
	else: # Applies knockback logic when the damage source is an enemy
		player.knockback_component.apply_knockback(damage_data["knockback_direction"], 300.0, duration)

func process_physics(_delta: float):
	timer -= _delta
	player.knockback_component.process_knockback(_delta)
	apply_gravity_and_move(_delta)
	
	if timer <= 0: # Knockback will apply before dying or going to run state
		if player.dying:
			return dead_state
			
		player.animation_player.play("flicker_hurt")
		if fallback_respawn:
			return respawn_state
		return run_state
	return null
